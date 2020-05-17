class WelcomeController < ApplicationController
  skip_before_action :authenticate

  def index
    redirect_to dashboard_index_path if current_user.persisted?
  end

  def sign_up
  end
end
