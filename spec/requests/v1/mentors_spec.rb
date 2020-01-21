require 'rails_helper'

RSpec.describe 'Mentor Requests', type: :request do

  #! The reason we are using `invalid_headers` is because we skipped authentication

  context 'When Empty Mentors' do
    before { Mentor.destroy_all }
    before {
      get '/api/v1/mentors/index',
          headers: invalid_headers()
    }

    it 'returns a list empty mentors' do
      expect(json_response[:mentors]).to be_empty
    end
  end

  context 'When Populated with mentors' do
    before { create_list(:mentor, 5) }
    before {
      get '/api/v1/mentors/index',
          headers: invalid_headers()
    }

    it 'returns a list empty mentors' do
      expect(json_response[:mentors]).to_not be_empty
    end
  end

  context 'When A single mentor is requested' do
    let!(:mentor) { create(:mentor, email: 'user@careerfoundry.com') }
    before {
      get '/api/v1/mentors/show',
          headers: invalid_headers(),
          params: { id: mentor.id }
    }

    it 'returns the requested mentor' do
      expect(json_response[:mentor][:id]).to eql(mentor.id)
    end
  end

  context 'When Non-Exisiting mentor is requested' do
    before {
      get '/api/v1/mentors/show',
          headers: invalid_headers(),
          params: { id: 0 }
    }

    it 'returns list of errors' do
      expect(json_response[:errors]).to_not be_empty
    end
  end

  context 'When mentor updates his/her avaialable appointments' do
    let!(:mentor) { create(:mentor, email: 'mentor@careerfoundry.com') }
    let!(:student) { create(:student, email: 'student@careerfoundry.com') }

    let!(:appointment) { create(:appointment, mentor: mentor, student: student)}

    before {
      post '/api/v1/mentors/update',
            headers: invalid_headers(),
            params: {
              id: mentor.id,
              appointment_id: appointment.id,
              status: 'rejected'
            }.to_json
    }

    it 'returns the updated appointment object' do
      expect(json_response[:appointment][:id]).to eql(appointment.id)
      expect(json_response[:appointment][:status]).to eql('rejected')
    end
  end

  context 'When mentor updates his/her avaialable appointments' do
    let!(:mentor) { create(:mentor, email: 'mentor@careerfoundry.com') }
    let!(:student) { create(:student, email: 'student@careerfoundry.com') }

    let!(:appointment) { create(:appointment, mentor: mentor, student: student)}

    before {
      post '/api/v1/mentors/update',
            headers: invalid_headers(),
            params: {
              id: 0,
              appointment_id: appointment.id,
              status: 'rejecte'
            }.to_json
    }

    it 'returns list of errors' do
      expect(json_response[:errors]).to_not be_empty
    end

  end
end
