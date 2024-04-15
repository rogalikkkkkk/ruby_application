class Image < ApplicationRecord

  belongs_to :theme

  # get images array of arrays by given theme_id
  scope :theme_images, -> (theme_id) {
    select('id','name','file','ave_value').where(theme_id: theme_id)
  }


end
