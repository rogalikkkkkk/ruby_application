class ImageSerializer < ActiveModel::Serializer
  attributes :id, :name, :file, :ave_value, :theme_id
end
