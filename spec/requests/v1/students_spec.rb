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

  context 'When a single student is requested' do
    let!(:student) { create(:student, email: 'student@careerfoundry.com') }
    before {
      get '/api/v1/users/students/show',
          headers: invalid_headers(),
          params: { student_id: student.id }
    }

    it 'returns the requested student' do
      expect(json_response[:student][:id]).to eql(student.id)
    end
  end

  context 'When non-existing student is requested' do
    before {
      get '/api/v1/users/students/show',
          headers: invalid_headers(),
          params: { student_id: 0 }
    }

    it 'returns list of errors' do
      expect(json_response[:errors]).to_not be_empty
    end
  end

  context 'When students updates appointment details ie title' do
    let!(:mentor)   { create(:mentor, email: 'mentor@careerfoundry.com' ) }
    let!(:student)  { create(:student, email: 'student@careerfoundry.com' ) }

    time_now = DateTime.now

    params = {
      title: 'My appointment slot',
      description: '',
      start_time: time_now,
      end_time: time_now + Appointment::MINIMUM_SLOT_TIME
    }

    before {
      post '/api/v1/users/students/create_appointment',
          headers: invalid_headers(),
          params: params
                    .merge({
                      mentor_id: mentor.id,
                      student_id: student.id
                    })
                    .to_json
    }

    it 'returns the created appointment object' do
      expect(json_response[:appointment][:status]).to eql('pending')
    end
  end

end
