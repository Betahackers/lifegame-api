class EndingsController < ApplicationController
  def index
    @endings = Ending.all
    render json: @endings
  end
end
