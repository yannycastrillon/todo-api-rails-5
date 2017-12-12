require 'rails_helper'

RSpec.describe Item, type: :model do
  # Association Tests
  # Ensure an Item belongs_to Todo
  it { should belong_to(:todo) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name)}
end
