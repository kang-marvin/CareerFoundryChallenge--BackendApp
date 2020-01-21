class AddIndexToAppointment < ActiveRecord::Migration[6.0]
  def change
    add_index :appointments, :student_id
    add_index :appointments, :mentor_id
  end
end
