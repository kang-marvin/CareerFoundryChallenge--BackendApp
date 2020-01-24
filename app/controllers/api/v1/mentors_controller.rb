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
        mentor = Mentor.find(mentors_params["mentor_id"])
        render json: mentor
      end

      def update_appointment
        mentor = Mentor.find(mentors_params["mentor_id"])
        appointment = mentor.appointments.find(mentors_params["appointment_id"])

        raise ActiveRecord::RecordNotFound and return if appointment.nil?

        appointment.update(status: mentors_params["status"])

        render json: appointment
      end

      private

      def mentors_params
        params
          .permit(
            :mentor_id,
            :student_id,
            :appointment_id,
            :name,
            :status
          )
      end

    end

  end
end
