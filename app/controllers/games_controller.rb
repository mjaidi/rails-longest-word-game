require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
  @letters = (0...9).map { ('A'..'Z').to_a[rand(26)] }
  end

  def result
    @grid = params[:grid].split
    @word = params[:word]
    session[:score] = session[:score] || 0
    if check(@word) == false
      @message = "the given word is not an english word"
      @score = session[:score] + 0  
      @current = 0
    elsif in_grid(@word, @grid) == false
      @message = "the given word is not in the grid"
      @score = session[:score] + 0
      @current = 0
    else
      @message = "well done checkout your score below"
      @score = session[:score] + @word.length**2
      @current = @word.length**2
    end
    session[:score] = @score
  end

  def in_grid(word, grid)
    word.chars.all? do |letter|
      word.upcase.count(letter.upcase) <= grid.count(letter.upcase)
    end
  end

  def check(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    dictionary_serialized = open(url).read
    JSON.parse(dictionary_serialized)["found"]
  end
end
