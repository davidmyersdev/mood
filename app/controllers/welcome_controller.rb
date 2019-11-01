class WelcomeController < ApplicationController
  skip_before_action :authenticate_by_token, only: [:index]

  def index
  end
end
