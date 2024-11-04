class CreateShopifyOrderItems < ActiveRecord::Migration[7.2]
  def change
    create_table :shopify_order_items do |t|
      t.string :order_id, null: false
      t.string :product_id, null: false
      t.string :variant_id, null: false
      t.string :title, null: false
      t.integer :quantity, null: false
      t.decimal :price, null: false
      t.string :customer_email, null: false
      t.string :customer_name, null: false
      t.string :customer_phone, null: false

      t.timestamps
    end

    add_index :shopify_order_items, :order_id, unique: true
    add_index :shopify_order_items, :product_id
    add_index :shopify_order_items, :customer_email
    add_index :shopify_order_items, :created_at
  end
end
