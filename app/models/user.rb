class User < ApplicationRecord
  # Model association
  has_many :todos, foreign_key: :created_by

  # Encrypt password
  has_secure_password

  # Validation
  validates_presence_of :name, :email, :password_digest
end
