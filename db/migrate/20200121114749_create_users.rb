class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|

      t.string :first_name, null: false, default: ''
      t.string :email, null: false, default: ''

      t.string :last_name

      t.string :time_zone, null: false, default: ''

      t.timestamps
    end

    add_index :users, :email, unique: true

  end
end
