class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|

      t.string :title, null: false, default: 'mentoring session'
      t.string :description

      # For status you can use enum
      # but I will use string to save time for now

      t.string :status, null: false, default: 'pending'
      t.string :video_link

      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
