class GameSerializer < ActiveModel::Serializer
  has_many :cards
  has_many :endings
end
