class RecipeSerializer < BaseSerializer
  type 'recipe'

  attributes :id, :created_at, :updated_at, :title, :descriptions, :time, :difficulty, :category_id, :user_id

  ATTR_FIELDS = %w[id created_at updated_at title descriptions time difficulty category_id user_id].freeze

  searchkick_attributes(ATTR_FIELDS)

  has_many :ingredients
end
