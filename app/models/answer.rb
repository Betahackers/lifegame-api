class Answer < ApplicationRecord
  has_many :points, dependent: :destroy
  belongs_to :card

  VALID_KINDS = %w(Left Right)

  validates_associated :card, :message => "Cannot have more than 2 answers for each card."

  validates_inclusion_of :kind, :in => VALID_KINDS, :message => "Must be left or right"
  validates_presence_of :text
  validates_presence_of :kind

  def kind_enum
    VALID_KINDS
  end
end
