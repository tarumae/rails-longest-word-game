require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      chars = ("A".."Z").to_a
      @letters << chars.sample
    end
  end

  def score
    @letters = params[:letters]
    @answer = params[:answer]
    validateAttempt(@letters, @answer)
  end

  def validateAttempt(letters, answer)
    @letters = letters.split(" ").map!(&:downcase)
    @answer = answer.downcase
    @result = {}
    if answer.chars.all? { |letter| @answer.count(letter) <= @letters.count(letter) }
      @result = apiRequest(@result, @answer)
    else 
      @result[:customError] = true
    end
  end

  def apiRequest(hash, answer)
    url = "https://wagon-dictionary.herokuapp.com/"
    JSON.parse(open(url + answer).read)
  end
end
