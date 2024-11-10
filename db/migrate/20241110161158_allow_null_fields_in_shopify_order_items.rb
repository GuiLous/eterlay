class AllowNullFieldsInShopifyOrderItems < ActiveRecord::Migration[7.2]
  def change
    change_column_null :shopify_order_items, :order_id, true
    change_column_null :shopify_order_items, :product_id, true
    change_column_null :shopify_order_items, :variant_id, true
  end
end
