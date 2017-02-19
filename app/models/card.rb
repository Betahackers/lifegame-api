class Card < ApplicationRecord
  has_many :answers, dependent: :destroy

  def self.shuffle(limit = 50)
    Card.all.order("RANDOM()").limit(limit)
  end

  def self.pick_random()
    Card.uncached { shuffle(1).first }
  end

  def constrained_by_age?(age)
    return false if age_constraint.blank?
    age_constraint < 0 ? age > age_constraint.abs : age < age_constraint
  end
end