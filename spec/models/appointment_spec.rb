require 'rails_helper'

RSpec.describe Appointment, type: :model do
  subject { build(:appointment) }

  describe 'Presence validations' do
    specify { should validate_presence_of(:title) }
  end

  describe 'Associations' do
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid with missing title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end
end
