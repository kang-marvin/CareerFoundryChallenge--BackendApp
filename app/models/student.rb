class Student < User
  has_many :appointments
  has_many :mentors, through: :appointments
end
