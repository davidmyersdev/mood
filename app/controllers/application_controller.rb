class ApplicationController < ActionController::Base
  include SetUser

  skip_before_action :verify_authenticity_token
  before_action :authenticate

  helper_method :current_user

  rescue_from StandardError do |error|
    Raven.capture_exception(error)

    flash.alert = 'An unknown error has occurred. Please try again.'

    redirect_to root_path
  end

  private

  def authenticate
    redirect_to root_path unless current_user.persisted?
  end
end
