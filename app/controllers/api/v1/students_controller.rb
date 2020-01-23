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
        student_id = student_params['id']
        student = Student.find(student_id)
        render json: student
      end

      private

      def student_params
        params
          .permit(
            :id
          )
      end

    end
  end
end
