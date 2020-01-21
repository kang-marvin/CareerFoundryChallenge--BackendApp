require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:mentor) }

  describe 'Associations' do
    it { should have_many(:appointments) }
    it { should have_many(:students).through(:appointments) }
  end

end
