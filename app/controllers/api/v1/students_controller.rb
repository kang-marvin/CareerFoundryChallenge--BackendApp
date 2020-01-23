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

    end
  end
end
