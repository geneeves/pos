class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.column :sale_id, :integer
      t.column :product_id, :integer
      t.column :quantity, :integer

      t.timestamps
    end
  end
end
