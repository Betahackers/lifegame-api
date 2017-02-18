class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :text, :points
  attribute :kind, key: :type
  has_many :points
end
