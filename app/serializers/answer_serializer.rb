class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :text
  attribute :kind, key: :type
  has_many :points
end
