class Value < ApplicationRecord

  belongs_to :user

  scope :all_values_by_user, -> (user_id) {
    user = User.find(user_id)
    user.values
  }

end
