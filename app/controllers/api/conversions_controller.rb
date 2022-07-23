# frozen_string_literal: true

class Api::ConversionsController < Api::BaseController
  def weight
    return render json: { message: I18n.t('errors.missing_weight') } unless params[:weight]
    return render json: { message: I18n.t('errors.missing_from_unit') } unless params[:from_unit]
    return render json: { message: I18n.t('errors.missing_to_unit') } unless params[:to_unit]

    result = ConversionService.new.convert_weight(params[:weight], params[:from_unit], params[:to_unit])

    render json: { result: result }
  end
end
