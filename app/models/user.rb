class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
  has_one :professional, dependent: :destroy
  has_one :professional_account_request
  has_many :appointments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :professionals, through: :reviews

  before_destroy :destroy_with_reviews, :destroy_professional_account_request

  private 

  def destroy_professional_account_request
    professional_account_request.destroy if professional_account_request
  end

  def destroy_with_reviews
    reviews.destroy_all if reviews
  end
end
