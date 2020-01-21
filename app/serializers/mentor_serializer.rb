class MentorSerializer < ActiveModel::Serializer
  attributes :id, :name, :time_zone, :calendar

  def name
    full_name = "#{object.first_name} #{object.last_name}"
    "#{full_name} (#{object.email})"
  end

  def calendar
    ActiveModelSerializers::SerializableResource.new(
      object.appointments,
      each_serializer: AppointmentSerializer,
      root: false
    ).as_json
  end
end
