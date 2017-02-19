class Ending < ApplicationRecord
  def self.randomized
    Ending.pluck(:reason).uniq.map do |reason|
      Ending.where(reason: reason).order("RANDOM()").first
    end
  end
end
