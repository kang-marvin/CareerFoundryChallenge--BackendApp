class LimitedMentorSerializer < ActiveModel::Serializer
  attributes :id, :name

  def name
    full_name = "#{object.first_name} #{object.last_name}"
    "#{full_name} (#{object.email})"
  end
end
