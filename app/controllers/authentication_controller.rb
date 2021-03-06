# app/controllers/authentication_controller.rb
class AuthenticationController < ApplicationController
  #  When signing up and authenticating a user we won't need a token.
  skip_before_action :authorize_request, only: :authenticate
  # return auth token once the user is authenticated
  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
