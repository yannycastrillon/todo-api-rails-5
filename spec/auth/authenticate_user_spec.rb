# spec/auth/authenticate_user_spec.rb 
require 'rails_helper'

RSpec.describe AuthenticateUser do
  # create test user
  let(:user) { create(:user) }
  #valid request subject
  subject(:valid_auth_obj) { described_class.new(user.email, user.password) } 
  # invalid request subject
  subject(:invalid_auth_obj) { described_class.new('foo','bar') }

  # Test suit for AthenticateUser#call
  describe '#call' do
    # return token when valid request
    context 'When valid credentials' do
      it 'returns an auth token' do
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end

    # raise Authentication Error when invalid request
    context 'When invalid credentials' do
      it 'raises an authentication error' do
        expect { invalid_auth_obj.call }
          .to raise_error(
            ExceptionHandler::AuthenticationError, /Invalid credentials/
          )
      end
    end
  end
end