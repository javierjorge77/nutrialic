class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :professional, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :reviews
  has_many :professionals, through: :reviews

end
