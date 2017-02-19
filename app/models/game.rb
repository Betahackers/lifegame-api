class Game < ApplicationRecord
  def cards
    @cards ||= Card.shuffle(70)
  end

  def endings
    @endings ||= Ending.all
  end
end
