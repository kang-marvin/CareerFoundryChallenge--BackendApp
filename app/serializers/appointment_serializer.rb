class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :title, :status, :start_time, :end_time

end
