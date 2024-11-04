class CreateTicketCodes < ActiveRecord::Migration[7.2]
  def change
    create_table :ticket_codes do |t|
      t.string :uuid
      t.references :shopify_order_item, foreign_key: true
      t.boolean :used, default: false
      t.datetime :used_at

      t.timestamps
    end

    add_index :ticket_codes, :uuid, unique: true
  end
end
