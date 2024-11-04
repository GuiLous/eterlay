class AddFieldsToTickets < ActiveRecord::Migration[7.2]
  def change
    add_column :tickets, :city, :string
    add_column :tickets, :state, :string
    add_column :tickets, :location, :string
    add_column :tickets, :date, :datetime
    add_column :tickets, :footer_description, :text
  end
end
