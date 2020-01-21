class AddStudentIdToAppointment < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments,
               :student_id,
               :integer,
               foreign_key: true,
               null: false

  end
end
