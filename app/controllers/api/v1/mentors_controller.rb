# frozen_string_literal: true

module Api
  module V1

    class MentorsController < Api::ApiApplicationController
      skip_before_action :authenticate_request

      def index
        mentors = Mentor.all
        render json: {
          mentors: each_with_serializer(
            array_data: mentors,
            serializer: LimitedMentorSerializer
          )[:mentors]
        }, status: :ok
      end

      def show
        mentor = Mentor.find(mentors_params["id"])
        render json: mentor
      end

      def update
        # Update an appointment's status (THIS SHOULD BE MOVED TO APPOINTMENT CONTROLLER)
        mentor = Mentor.find(mentors_params["id"])
        appointment = mentor.appointments.find(mentors_params["appointment_id"])

        render json: {
          errors: appointment.errors.full_messages
        }, status: :unproceable_entity unless appointment.update!(status: mentors_params["status"])

        render json: appointment
      end

      private

      def mentors_params
        params
          .permit(
            :id,
            :name,
            :student_id,
            :appointment_id,
            :status
          )
      end

    end

  end
end
