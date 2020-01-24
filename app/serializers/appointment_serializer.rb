class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :title, :status, :description, :start_time, :end_time

end
