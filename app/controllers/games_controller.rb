require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    7.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    @grid = params[:grid]
    @word = params[:word].upcase
    @included = included?(@word, @grid)
    @english = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
