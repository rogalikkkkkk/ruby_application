class Theme < ApplicationRecord

  has_many :images

  scope :find_theme_id, -> (theme) { self.find_by(name: theme).id }
  
end
