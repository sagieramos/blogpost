class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def not_found
    render json: { error: 'Endpoint not found' }, status: :not_found
  end
end
