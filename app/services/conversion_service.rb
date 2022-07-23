# frozen_string_literal: true

class ConversionService
  def convert_weight(weight, from_unit, to_unit)
    Success.new(success: Conversions::Weight.new(weight.to_i, from_unit, to_unit).send("to_#{to_unit}"))
  rescue NoMethodError
    Failure.new("Conversion to '#{to_unit}' not available. Available options are t, kg, mg and g.")
  end
end
