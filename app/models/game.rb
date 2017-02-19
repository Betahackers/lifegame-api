class Game < ApplicationRecord
  def cards
    @cards ||= Card.shuffle
  end

  def endings
    @endings ||= Ending.all
  end
end
