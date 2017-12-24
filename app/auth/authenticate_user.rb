class AuthenticateUser
    def initialize(email, password)
       @email = email
       @password = password 
    end

    #service entry point
    # It should return a token when user credentials are valid and raise an error when they're not. 
    # Running the auth specs and they should fail with a load error
    def call
      JsonWebToken.encode(user_id: user.id) if user
    end

    private

    attr_reader :email, :password

    # verify user credentials
    def user
      user = User.find_by(email: email)
      return user if user && user.authenticate(password)
      # raise Authentication error if credentials are invalid
      raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
    end
end