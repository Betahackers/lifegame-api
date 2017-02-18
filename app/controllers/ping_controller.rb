class PingController < ApplicationController
  def ping
    render json: { text: "Hello World" }
  end
end
