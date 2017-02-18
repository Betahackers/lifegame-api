class Card < ApplicationRecord
  has_many :answers, dependent: :destroy
end
