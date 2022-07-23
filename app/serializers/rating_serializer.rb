class RatingSerializer < BaseSerializer
  type 'rating'

  attributes :score

  belongs_to :user
end
