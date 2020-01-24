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
      expect(json_response[:appointment][:title]).to eql('My appointment slot')
    end
  end

  context 'When student deletes an appointment' do
    let!(:mentor)   { create(:mentor, email: 'mentor@careerfoundry.com' ) }
    let!(:student)  { create(:student, email: 'student@careerfoundry.com' ) }

    let!(:appointments) {
      create_list(:appointment, 5, mentor: mentor, student: student)
    }

    params = {}

    before {
      delete '/api/v1/users/students/delete_appointment',
            headers: invalid_headers(),
            params: params
                      .merge({
                        appointment_id: appointments.pluck(:id).sample,
                        student_id: student.id
                      })
                      .to_json
    }

    it 'returns success message' do
      expect(json_response[:message]).to eql('Appointment deleted successfully')
    end

    it 'returns student remaining appointments' do
      expect(json_response[:student][:calendar][:appointments].count).to eql(4)
    end

    it 'returns student object' do
      expect(json_response[:student][:id]).to eql(student.id)
    end
  end

  context 'When student deletes non-exisiting appointment' do
    let!(:student)  { create(:student, email: 'student@careerfoundry.com' ) }
    before {
      delete '/api/v1/users/students/delete_appointment',
            headers: invalid_headers(),
            params: {
                      appointment_id: 0,
                      student_id: student.id
                    }.to_json
    }

    it 'returns list of errors' do
      expect(json_response[:errors]).to_not be_empty
    end
  end

  context 'When student updates details of appointment' do
    let!(:mentor)   { create(:mentor, email: 'mentor@careerfoundry.com' ) }
    let!(:student)  { create(:student, email: 'student@careerfoundry.com' ) }

    let!(:appointments) {
      create_list(:appointment, 5, mentor: mentor, student: student)
    }

    time_in_30_minutes = DateTime.now + 30.minutes

    before {
      post '/api/v1/users/students/update_appointment',
            headers: invalid_headers(),
            params: {
                      appointment_id: appointments.pluck(:id).first,
                      student_id: student.id,
                      title: 'New Appointment Title',
                      end_time: time_in_30_minutes,
                      description: 'New Appointment Description',
                    }.to_json
    }

    it 'returns the updated appointment object' do
      expect(json_response[:appointment][:status]).to eql('pending')
      expect(json_response[:appointment][:title]).to eql('New Appointment Title')
      expect(json_response[:appointment][:description]).to eql('New Appointment Description')
    end
  end

  context 'When student updates details of appointment he/she didn\'t create'  do
    let!(:mentor)   { create(:mentor, email: 'mentor@careerfoundry.com' ) }
    let!(:student_one)  { create(:student, email: 'student1@careerfoundry.com' ) }
    let!(:student_two)  { create(:student, email: 'student2@careerfoundry.com' ) }

    let!(:std_1_appointments) {
      create_list(:appointment, 5, mentor: mentor, student: student_one)
    }
    let!(:std_2_appointments) {
      create_list(:appointment, 2, mentor: mentor, student: student_two)
    }

    time_in_30_minutes = DateTime.now + 30.minutes

    before {
      post '/api/v1/users/students/update_appointment',
            headers: invalid_headers(),
            params: {
                      appointment_id: std_1_appointments.pluck(:id).first,
                      student_id: student_two.id,
                      title: 'New Appointment Title',
                      end_time: time_in_30_minutes,
                      description: 'New Appointment Description',
                    }.to_json
    }

    it 'returns list of errors' do
      expect(json_response[:errors]).to_not be_empty
    end
  end

  context 'When student updates details of non-exisitng appointment' do
    let!(:student)  { create(:student, email: 'student@careerfoundry.com' ) }

    time_in_30_minutes = DateTime.now + 30.minutes

    before {
      post '/api/v1/users/students/update_appointment',
            headers: invalid_headers(),
            params: {
                      appointment_id: 0,
                      student_id: student.id,
                      title: 'New Appointment Title',
                      end_time: time_in_30_minutes,
                      description: 'New Appointment Description',
                    }.to_json
    }

    it 'returns list of errors' do
      expect(json_response[:errors]).to_not be_empty
    end
  end

end
