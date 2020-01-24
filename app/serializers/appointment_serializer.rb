class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :title, :status, :description, :start_time, :end_time


  def start_time
    format_time(object.start_time)
  end

  def end_time
    format_time(object.end_time)
  end

  private

  def format_time(time)
    time.strftime('%D %I:%M %p')
  end
end
