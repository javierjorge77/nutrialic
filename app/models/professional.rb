class Professional < ApplicationRecord

  belongs_to :user
  has_many :appointments
  has_one_attached :photo
  geocoded_by :adress
  after_validation :geocode, if: :will_save_change_to_adress?

end
