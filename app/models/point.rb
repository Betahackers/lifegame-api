class Point < ApplicationRecord
  belongs_to :answer

  VALID_SLUGS =      %w(health fun money love)

  validates_inclusion_of :slug, in: VALID_SLUGS
  validates_presence_of :slug, :value
  validates_numericality_of :value

  def slug_enum
    VALID_SLUGS
  end

  def title
    "#{slug} #{value}"
  end
end
