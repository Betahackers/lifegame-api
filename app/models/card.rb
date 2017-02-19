class Card < ApplicationRecord
  has_many :answers, dependent: :destroy

  validates_presence_of :person
  validates_presence_of :title
  validates_presence_of :age_constraint
  validates_presence_of :answers

  def self.shuffle(limit = 50)
    Card.all.includes(answers: :points).order("RANDOM()").limit(limit)
  end

  def self.pick_random()
    Card.uncached { shuffle(1).first }
  end

  def constrained_by_age?(age)
    return false if age_constraint.blank?
    age_constraint < 0 ? age > age_constraint.abs : age < age_constraint
  end
end