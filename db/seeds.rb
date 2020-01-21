# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Mentor.destroy_all

5.times {
  mentor_data = {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    time_zone: "-02:00"
  }

  Mentor.create(mentor_data)
}

puts "Mentors created successfully\n\n"

Student.destroy_all

5.times {
  student_data = {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    time_zone: "-03:00"
  }

  Student.create(student_data)
}

puts "Students created successfully\n\n"

Appointment.destroy_all

5.times {
  current_time = DateTime.now
  appointment_data = {
    title:       'Mentoring Session',
    description: '',
    video_link:  '',
    start_time:  current_time,
    end_time:    current_time + Appointment::MINIMUM_SLOT_TIME,
  }

  invloved_partners = {
    student_id: Student.all.sample.id,
    mentor_id: Mentor.all.sample.id,
  }

  Appointment.create(appointment_data.merge!(invloved_partners))
}

puts "Appointments created successfully\n\n"

puts 'Seeding completed...'


