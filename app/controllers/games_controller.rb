require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    letters = "ABCEDFGHIGKLMNOPQRSTUVWXYZ"*5
    letter = letters.split("")
    @letters = letter.sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @grid_word = inside_grid?(@word, @letters)
    @english_word = english_word?(@word)
  end


  def english_word?(word)
    url = "https://recode-dictionary.herokuapp.com/#{word}"
    valids = open(url).read
    user = JSON.parse(valids)
    return user['found']
  end

 
  def inside_grid?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter.capitalize) }
  end

end
