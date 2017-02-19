class Card < ApplicationRecord
  has_many :answers, dependent: :destroy

  def self.shuffle(limit = 50)
    Card.all.order("RANDOM()").limit(limit)
  end
end
