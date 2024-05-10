class Value < ApplicationRecord

  belongs_to :user

  scope :all_values_by_user, -> (user_id) {
    user = User.find(user_id)
    user.values
  }

  scope :user_valued_image, -> (current_user_id, image_id) { where(user_id: current_user_id, image_id: image_id) }

  def self.user_valued_exists(current_user_id, image_id)
    value_image = user_valued_image(current_user_id, image_id)
    if value_image.blank?
      rez = 0
      value = 0
    else
      rez = 1
      value = value_image[0].value
    end
    return rez, value
  end

end
