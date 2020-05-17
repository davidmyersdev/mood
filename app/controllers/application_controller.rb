class ApplicationController < ActionController::Base
  include SetUser

  skip_before_action :verify_authenticity_token
  before_action :authenticate

  private

  def authenticate
    redirect_to root_path unless current_user.persisted?
  end
end
