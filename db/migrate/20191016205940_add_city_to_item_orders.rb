class AddCityToItemOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :item_orders, :city, :string
  end
end
