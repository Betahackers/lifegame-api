class CardsController < ApplicationController
  def index
    @cards = Card.shuffle(limit)
    render json: @cards, include: "answers.points"
  end

  private

  def limit
    params[:limit] || default_limit
  end

  def default_limit
    70
  end
end
