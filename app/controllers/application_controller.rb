# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotUnique, with: :error_render_method
  rescue_from ActiveModel::UnknownAttributeError, with: :error_render_method

  def error_render_method(e)
    if e.cause.nil?
      error_code = 'internal_server_error'
      extra = { 'exception' => e.to_s }
    else
      error_code = e.cause.class.to_s
      extra = { 'exception' => e.cause.message }
    end
    render_json_error(:internal_server_error, error_code, extra)
  end

  def render_json_error(status, error_code, extra = {})
    status = Rack::Utils::SYMBOL_TO_STATUS_CODE[status] if status.is_a? Symbol

    error = {
      lang: I18n.locale,
      message: I18n.t("error_messages.#{error_code}.message"),
      internal_message: I18n.t("error_messages.#{error_code}.internal_message"),
      status: status
    }.merge(extra)

    detail = I18n.t("error_messages.#{error_code}.detail", default: '')
    error[:detail] = detail unless detail.empty?

    render json: { error: error }, status: status
  end
end
