class RanameUserTable < ActiveRecord::Migration[7.2]
  def change
    rename_table :users, :admins
  end
end
