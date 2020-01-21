class Appointment < ApplicationRecord

  # Notes:
    #! Only mentor can approve or reject appointment.

  STATUS = [ 'pending', 'approve', 'rejected' ].freeze

  MINIMUM_SLOT_TIME = (30.minutes)

  validates :title,
            presence: true

  validates :status,
            inclusion: { in: STATUS }

end