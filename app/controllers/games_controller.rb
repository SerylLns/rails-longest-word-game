require 'json'
require 'open-uri'
class GamesController < ApplicationController

  def new
    @letters = random
     
  end

  def score
    userwords = params[:result]
    letters = params[:letters]
    session[:score] = "0"
    if isValid?(letters.split(""), userwords.split(""))
      if validWord?(userwords)
        result = validWord?(userwords)
        session[:score] = result["length"]
        @response = " #{userwords} IS GOOD !!!"
      else
        @response = "Your word: #{userwords} is not english word"
      end
    else
      @response = "Your word: #{userwords} is invalid with letters: #{letters} "
    end
  end
  
  private

  def validWord?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = open(url).read
    word = JSON.parse(word_serialized)
    if word["found"] == true
      return word
    end
    return false
  end

  def isValid?(letters, results)
    compare = results.reject{|res| letters.include?(res)}
    if compare.empty?
      return true
    end
    return false
  end

  def random
    # 10 lettres random
    result = []
    alphabet = ('a'..'z').to_a
    10.times do
      result << alphabet[rand(26)]
    end
    return result
  end
end
