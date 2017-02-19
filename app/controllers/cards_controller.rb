class CardsController < ApplicationController

  def index
    @cards = Card.ordered(limit)
    render json: @cards, include: "answers.points"
  end

  private

  def limit
    params[:limit] || default_limit
  end

  def default_limit
    50
  end
end
