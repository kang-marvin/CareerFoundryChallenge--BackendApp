require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:student) }

  describe 'Associations' do
    it { should have_many(:appointments) }
    it { should have_many(:mentors).through(:appointments) }
  end

end
