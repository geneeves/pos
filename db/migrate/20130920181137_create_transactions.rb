class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.column :cashier_id, :integer
      t.column :date, :date

      t.timestamps
    end
  end
end
