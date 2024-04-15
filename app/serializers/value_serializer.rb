class ValueSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :image_id, :value
end
