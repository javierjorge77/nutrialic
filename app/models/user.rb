class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_one :professional, dependent: :destroy
  has_one :professional_account_request
  has_many :appointments, dependent: :destroy
  has_many :reviews
  has_many :professionals, through: :reviews
end
