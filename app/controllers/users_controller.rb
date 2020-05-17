class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:sign_out, :sign_up]

  def sign_in
    redirect_to dashboard_index_path
  end

  def sign_out
    reset_session

    @current_user = nil

    redirect_to root_path
  end

  def sign_up
    @current_user = User.create!(email: user_params[:email], password: user_params[:password])

    redirect_to dashboard_index_path
  end

  private

  def authenticate
    @current_user = User.find_by!(email: user_params[:email]).authenticate(user_params[:password])

    super
  rescue ActiveRecord::RecordNotFound => _error
    redirect_to root_path
  end

  def user_params
    params.permit(
      :email,
      :password,
    )
  end
end
