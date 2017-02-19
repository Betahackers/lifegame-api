class EndingsController < ApplicationController
  def index
    @endings = Ending.randomized
    render json: @endings
  end
end
