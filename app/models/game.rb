class Game < ApplicationRecord
  def cards
    @cards = Card.all
  end

  def endings
    []
  end
end
