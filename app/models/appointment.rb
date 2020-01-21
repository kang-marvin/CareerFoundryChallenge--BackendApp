class Appointment < ApplicationRecord

  # Notes:
    #! Only mentor can approve or reject appointment.

  STATUS = [ 'pending', 'approved', 'rejected' ].freeze

  MINIMUM_SLOT_TIME = (30.minutes)

  validates :title,
            presence: true

  validates :status,
            inclusion: { in: STATUS }

  belongs_to :mentor
  belongs_to :student
end
