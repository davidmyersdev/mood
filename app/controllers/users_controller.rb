class UsersController < ApplicationController
  skip_before_action :authenticate_by_token, only: [:sign_in]
  before_action :authenticate_by_creds, only: [:sign_in]

  def current
    render json: current_user
  end

  def sign_in
    render json: { user: current_user, token: JwtService.encode(id: current_user.id) }
  end
end
