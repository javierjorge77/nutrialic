class Professional < ApplicationRecord
  include PgSearch::Model
  belongs_to :user
  pg_search_scope :search_by_fields,
  against: [:adress, :branch, :diploma, :first_cost, :follow_cost],
  associated_against: { user: [:name, :lastname] },
  using: {
    tsearch: { prefix: true, any_word: true }
  }
  has_many :appointments
  has_one_attached :photo
  has_many :gallery_images, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one :about_section, dependent: :destroy
  has_many :users, through: :reviews, dependent: :destroy
  validates :first_cost, presence: true
  validates :follow_cost, presence: true
  validates :diploma, presence: true
  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum:5, maximum:15}
  validates :confirmed, inclusion: { in: [true], message: "must be confirmed" }, on: :update
end
