class Game < ApplicationRecord
  def cards
    @cards ||= Card.ordered(80)
  end

  def endings
    @endings ||= Ending.randomized
  end
end
