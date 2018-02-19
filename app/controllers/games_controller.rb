require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...rand(5..10)).map { ('A'..'Z').to_a[rand(26)] }
    @letters = @letters.join
  end

  def score
    @word = params[:word].downcase
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    dictionary = open(url).read
    word_info = JSON.parse(dictionary)
    @word_found = word_info["found"]
    @word_length = word_info["length"].to_i
    @word = @word.split("")
    @letters = params[:randomword].downcase.split("")
    @intersection = @word & @letters
    @intersection = @intersection.length

    if @word.empty?
      @result = "You didn't give me a word!"
    elsif @intersection < 2
      @result = "Use the letters given to you!"
    elsif @word_found == false
      @result = "#{@word.join} is not a word"
    elsif @word_found == true && @intersection >= 2
      @result = "Congrats! #{@word.join.capitalize} is a word. Score #{@intersection}"
    end
  end

end
