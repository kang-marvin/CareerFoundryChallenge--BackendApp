class Mentor < User
  has_many :appointments
  has_many :students, through: :appointments
end
