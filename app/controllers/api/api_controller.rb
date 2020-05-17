module Api
  class ApiController < ActionController::Base
    include SetUser

    skip_before_action :verify_authenticity_token
    before_action :authenticate

    private

    def authenticate
      head :forbidden unless current_user.persisted?
    end
  end
end
