class AddManualToShopifyOrderItems < ActiveRecord::Migration[7.2]
  def change
    add_column :shopify_order_items, :manual, :boolean, default: false
  end
end
