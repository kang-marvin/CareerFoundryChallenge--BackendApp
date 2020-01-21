# Career Foundry Code Challenge (backend application)

## **Models**

  1. User table (single table inheritance)
      - Student
      - Mentor

  2. Appointemt table

### **Models :: Relationships**
  1. Student
     - `has_many` Appointments
     - `has_many` Mentors `through` Appointments

  2. Mentor
     - `has_many ` Appointments
     - `has_many` Students `through` Appointments

  3. Appointment
      - `belongs_to` Student
      - `belongs_to` Mentor

### **Models :: Variables**

  1. User (Student & Mentor)
      > name

      > email

      > time_zone

  2. Appointment
      > title

      > student_id

      > mentor_id

      > description

      > status [ pending, rejected, approved ]

      > video_link ( *nil* for right now )

      > start_time

      > end_time




