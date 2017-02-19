class Ending < ApplicationRecord
  def self.randomized
    Ending.all.order("RANDOM()")
  end
end
