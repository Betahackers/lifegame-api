class CardsController < ApplicationController
  def index
    @cards = Card.limit(70)
    render json: @cards, include: "answers.points"
  end
end
