class ChangeNameFromTransactionstoSales < ActiveRecord::Migration
  def change
    rename_table :transactions, :sales
  end
end
