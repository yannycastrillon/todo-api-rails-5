require 'rails_helper'

RSpec.describe User, type: :model do
  # Association test
  # Ensure model has 1:m relationship with Todo model
  it { should have_many(:todos) }
  # Validation Test
  # Ensure name, email and password digest are present before save.
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end
