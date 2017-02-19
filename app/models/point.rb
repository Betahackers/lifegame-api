class Point < ApplicationRecord
  belongs_to :answer

  def title
    "#{slug} #{value}"
  end
end
