class Answer < ApplicationRecord
  has_many :points, dependent: :destroy
  belongs_to :card

  validates_inclusion_of :kind, :in => %w(Left Right)
  validates_presence_of :text
  validates_presence_of :kind
end
