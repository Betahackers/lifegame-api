class Answer < ApplicationRecord
  has_many :points, dependent: :destroy
  belongs_to :card
end
