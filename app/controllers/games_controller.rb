require 'open-uri'
require 'json'

class GamesController < ApplicationController
    def new
        @result = []
        10.times do
          @result << ('A'..'Z').to_a.sample
        end
    end

    def score
        @word = params[:word]
        @result = params[:result]
        @response = ""
        @score = 0
        @message = ""
        @result = @result.downcase.split(" ")

        if english_word?(@word)
          @response = "Yes"
          @word2 = @word.split('')
          i = 0
          while i != @word2.length
            if @result.include?(@word2[i])
              win = "oui"
              i += 1
            else 
              win = "non"
              i = @word2.length
            end
          end
        else
          @response = "not an english word"
          @score = 0
        end

        if win == "oui"
          @message = "well done"
          @score = 200
        else
          @score = 0
          @message = "not in the grid"
        end
    end

    def english_word?(word)
        isword = open("https://wagon-dictionary.herokuapp.com/#{word}")
        json = JSON.parse(isword.read)
        return json['found']
    end
      
end
