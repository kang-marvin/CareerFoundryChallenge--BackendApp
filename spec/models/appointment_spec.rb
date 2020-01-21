require 'rails_helper'

RSpec.describe Appointment, type: :model do

  before(:all) do
    Student.destroy_all
    Mentor.destroy_all

    create_list(:student, 5)
    create_list(:mentor, 5)
  end

  subject {
    build(
      :appointment,
      student: Student.all.sample,
      mentor: Mentor.all.sample,
      )
    }

  describe 'Presence validations' do
    specify { should validate_presence_of(:title) }
  end

  describe 'Associations' do
    it { should belong_to(:mentor) }
    it { should belong_to(:student) }
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid with missing title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end
end
