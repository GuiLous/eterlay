class ChangeCustomerPhoneToNullableInShopifyOrderItems < ActiveRecord::Migration[7.2]
  def change
    change_column_null :shopify_order_items, :customer_phone, true
  end
end
