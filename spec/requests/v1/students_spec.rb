require 'rails_helper'

RSpec.describe 'Student Requests', type: :request do

  context 'When No Students' do
    before { Student.destroy_all }
    before {
      get '/api/v1/users/students/index',
          headers: invalid_headers()
    }

    it 'returns a list of empty students' do
      expect(json_response[:students]).to be_empty
    end
  end

  context 'When Populated with Students' do
    before { Student.destroy_all }
    before { create_list(:student, 5) }
    before {
      get '/api/v1/users/students/index',
          headers: invalid_headers()
    }

    it 'returns a list of existing students' do
      expect(json_response[:students]).to_not be_empty
    end

    it 'returns all the students' do
      expect(json_response[:students].count).to eql(5)
    end
  end

end
