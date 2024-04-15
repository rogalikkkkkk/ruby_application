class Value < ApplicationRecord

  belongs_to :user

  scope :all_values_by_user, -> (user_id) {
    select('user_id','image_id','value').where(user_id: user_id)
  }

#   TODO: почему-то при выполнении выводит также id: nil

end
