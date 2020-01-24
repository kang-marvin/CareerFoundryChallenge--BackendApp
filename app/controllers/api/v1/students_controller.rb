# frozen_string_literal: true

module Api
  module V1

    class StudentsController < Api::ApiApplicationController
      skip_before_action :authenticate_request

      def index
        students = Student.all
        render json: {
          students: each_with_serializer(
            array_data: students,
            serializer: LimitedStudentSerializer
          )[:students]
        }, status: :ok
      end

      def show
        student_id = student_params['student_id']
        student = Student.find(student_id)
        render json: student
      end

      def create_appointment
        student = Student.find(student_params['student_id'])
        mentor  = Mentor.find(mentor_params['mentor_id'])

        appointment = student.appointments.new(
                        appointment_params.merge(mentor: mentor)
                      )

        render json: {
          errors: appointment.errors.full_messages
        }, status: :unproceable_entity unless appointment.save!

        render json: appointment
      end

      def delete_appointment
        student = Student.find(student_params['student_id'])
        appointment_id = params['appointment_id']

        appointment = student
                        .appointments
                        .where(id: appointment_id)
                        .first

        raise ActiveRecord::RecordNotFound and return if appointment.nil?

        appointment.delete

        render json: {
          student: StudentSerializer.new(student),
          message: "Appointment deleted successfully"
        }, status: :ok
      end

      private

      def student_params
        params.permit(:student_id)
      end

      def mentor_params
        params.permit(:mentor_id)
      end

      def appointment_params
        params
          .permit(
            :title,
            :description,
            :start_time,
            :end_time
          )
      end

    end
  end
end
