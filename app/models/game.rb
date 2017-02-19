class Game < ApplicationRecord
  def cards
    @cards ||= Card.all
  end

  def endings
    @endings ||= Ending.all
  end
end
