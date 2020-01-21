require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'Presence validations' do
    specify { should validate_presence_of(:email) }
    specify { should validate_presence_of(:first_name) }
  end

  describe 'Uniqueness validations' do
    specify { should validate_uniqueness_of(:email) }
  end

  describe 'Associations' do
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid with incorrect email format' do
    subject.email = 'relish.subject'
    expect(subject).to_not be_valid
  end
end
