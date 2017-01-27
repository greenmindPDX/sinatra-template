class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :merchant_id
      t.integer :shopper_id
      t.float :total_cost
      t.boolean :shipped, :default => false
      t.timestamps null: false
    end
  end
end
