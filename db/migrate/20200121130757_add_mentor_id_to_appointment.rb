class AddMentorIdToAppointment < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments,
               :mentor_id,
               :integer,
               foreign_key: true,
               null: false
  end
end
