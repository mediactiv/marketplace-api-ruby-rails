class ProductSerializer < ActiveModel::Serializer
  attributes :id, :id, :title, :price, :published ,:user_id
  # has_one :user #this is the line
  #embed :ids
end
