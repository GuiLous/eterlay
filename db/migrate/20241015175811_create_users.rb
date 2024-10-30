class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :phone_number, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.boolean :is_active, default: true, null: false

      t.timestamps
    end

    add_index :users, :phone_number, unique: true
  end
end
