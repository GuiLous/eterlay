class CreateTickets < ActiveRecord::Migration[7.2]
  def change
    create_table :tickets do |t|
      t.string :name, null: false
      t.string :description
      t.timestamps
    end

    add_index :tickets, :name, unique: true
  end
end
