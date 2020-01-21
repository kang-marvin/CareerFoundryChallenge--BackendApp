FactoryBot.define do
  factory :appointment do
    title       { 'Mentoring Session' }
    description { '' }
    video_link  { '' }
    start_time  { DateTime.now }
    end_time    { DateTime.now + Appointment::MINIMUM_SLOT_TIME }
  end
end
