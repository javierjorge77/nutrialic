class Appointment < ApplicationRecord
  has_secure_token :authentication_token
  belongs_to :user
  belongs_to :professional
  validates :date, presence: true
  validates :time, presence: true
end
