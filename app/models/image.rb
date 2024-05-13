class Image < ApplicationRecord

  belongs_to :theme
  has_many :value

  # get images array of arrays by given theme_id
  scope :theme_images, -> (theme_id) {
    select('id','name','file','ave_value').where(theme_id: theme_id)
  }
  def self.update_values(new_value_data)
    image_id = new_value_data[:image_id]
    Value.create(new_value_data)
    values_arr = Value.where(image_id: image_id).pluck(:value)
    values_sum = values_arr.inject(:+)
    avg_value = values_sum/values_arr.size
    avg_value.round
    image = find(image_id)
    image.update(ave_value: avg_value)
    theme_id = new_value_data[:theme_id]
    current_user_id = new_value_data[:user_id]
    user_valued, value = Value.user_valued_exists(current_user_id, image_id)
    values_qty = Value.all.count.round

    common_ave_value = find(image_id).ave_value.round

    data = {
      values_qty: values_qty,
      current_user_id: current_user_id,
      theme_id: theme_id,
      image_id: image_id,
      user_valued: user_valued,
      value: value,
      common_ave_value: common_ave_value
    }
    data
  end

end
