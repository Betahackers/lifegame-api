class Game < ApplicationRecord
  def cards
    @cards ||= Card.ordered(50)
  end

  def endings
    @endings ||= Ending.all
  end
end
