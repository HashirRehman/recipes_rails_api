# frozen_string_literal: true

module RecipeSearch
  extend ActiveSupport::Concern

  FIELDS = %i[title time].freeze
  FILTERS = %i[difficulty].freeze

  included do
    searchkick word_middle: FIELDS

    def self.search_for_index(params = {})
      search_params = default_search_options(params)

      search_params[:order] = order_hash(params, search_params[:order])
      search_params[:where] = where_hash(params, search_params[:where])

      elastic_search(params[:search], search_params)
    end

    def self.default_search_options(params)
      options = {
        fields: FIELDS,
        match: :word_middle,
        load: false,
        misspellings: false
      }

      where_clause(params) ? options.merge!(where_clause(params)) : options
    end

    def self.where_clause(params)
      return unless params

      conditions = {}

      if params.dig(:time)
        time_limit = params.dig(:time).split('-').map(&:strip)
        start_limit = time_limit.first
        end_limit = time_limit.last

        conditions.merge!(
          time: start_limit != end_limit ? { gte: start_limit, lt: end_limit } : start_limit
        )
      end

      { where: conditions } if conditions.present?
    end
  end
end
