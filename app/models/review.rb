class Review < ApplicationRecord
    belongs_to :professional
    belongs_to :user
    validates :score, presence: true
    validates :comment, presence: true
end