class UsersController < ApplicationController
  skip_before_action :authenticate_by_session, only: [:sign_in, :sign_out, :sign_up]
  before_action :authenticate_by_creds, only: [:sign_in]

  def current
    render json: { user: current_user }
  end

  def sign_in
    redirect_to dashboard_index_path
  end

  def sign_out
    reset_session

    @current_user = nil
    @subscription = nil

    redirect_to root_path
  end

  def sign_up
    @current_user = User.create!(email: user_params[:email], password: user_params[:password])

    redirect_to dashboard_index_path
  end

  private

  def authenticate_by_creds
    User.find_by!(email: user_params[:email]).authenticate(user_params[:password]).tap do |user|
      return redirect_to root_path unless user

      @current_user = user
    end
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
