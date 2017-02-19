class GamesController < ApplicationController
  def show
    render json: Game.new, include: "cards.answers.points, endings"
  end
end
