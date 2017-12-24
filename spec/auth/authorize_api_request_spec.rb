require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  # Create a Test user
  let(:user) { create(:user) }

  # Mock 'Authorization' header
  let(:header) { { 'Authorization' => token_generator(user.id) } }

  # Invalid request subject
  subject(:invalid_request_obj) { described_class.new({}) }

  # Valid request subject
  subject(:request_obj) { described_class.new(header) }

  # Test Suit for AuthorizeApiRequest#call
  # This is our entry point into the serivice class
  describe '#call' do
    # returns user object when request is valid
    context 'When valid request' do
      it "returns user object" do
        result = request_obj.call
        expect(result[:user]).to eq(user)
      end
    end

    context 'When invalid request' do
      context 'When MissingToken' do
        it "raises a MissingToken Error" do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::MissingToken, /Missing token/)
        end
      end

      context 'When invalid Token' do
        subject(:invalid_request_obj) do
          # custom helper method 'token_generator '
          described_class.new('Authorization' => token_generator(5))
        end

        it "raises an Invalid Token error" do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
        end
      end

      context 'When token is expired' do
        let(:header) { { 'Authorization' => expired_token_generator(user.id) } }
        subject(:request_obj) { described_class.new(header) }

        # it "raises ExceptionHandler::ExpiredSignature error" do
        #   expect { request_obj.call }
        #     .to raise_error(ExceptionHandler::InvalidToken, /Signature has expired/)
        # end
      end
    end
  end
end
