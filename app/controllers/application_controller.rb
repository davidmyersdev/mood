class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :authenticate_by_token

  private

  def current_user
    @current_user ||= User.new
  end

  def authenticate_by_creds
    User.find_by!(email: creds_params[:email]).authenticate(creds_params[:password]).tap do |user|
      return head :unauthorized unless user

      @current_user = user
    end
  rescue ActiveRecord::RecordNotFound => _e
    head :unauthorized
  end

  def authenticate_by_token
    JwtService.decode(request.headers['Authorization'].split(' ').last).tap do |token|
      @current_user = User.find(token[:payload][:id])
    end
  rescue JWT::ExpiredSignature, JWT::DecodeError, JWT::VerificationError => _e
    head :unauthorized
  end

  def creds_params
    params.permit(:email, :password)
  end
end
