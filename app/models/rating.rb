class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :score, numericality: { less_than_or_equal_to: 5, only_integer: true }
end
