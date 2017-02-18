class CardSerializer < ActiveModel::Serializer
  attributes :id, :title, :person, :image_url, :answers
  has_many :answers
end
