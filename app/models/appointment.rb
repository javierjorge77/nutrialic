class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :professional
  validates :date, presence: true
  validates :time, presence: true
end
