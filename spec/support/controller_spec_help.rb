require 'rails_helper'

# spec/support/controller_spec_helper.rb
module ControllerSpecHelper
  # Generate users token from user id
  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  # Generate expired tokens from user id
  def expired_token_generator(user_id)
    JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 10))
  end

  # return valid headers
  def  valid_headers
    {
      'Authorization' => token_generator(user.id),
      'content-type' => "application/json"
    }
  end

  # return invalid header
  def invalid_headers
    {
      'Authorization' => nil,
      'content-type' => 'application/json'
    }
  end
end
