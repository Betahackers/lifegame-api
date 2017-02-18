class CardsController < ApplicationController
  def index
    @cards = Card.limit(5)
    render json: @cards.includes(answers: :points)
  end
end
