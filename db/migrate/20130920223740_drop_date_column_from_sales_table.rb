class DropDateColumnFromSalesTable < ActiveRecord::Migration
  def change
    remove_column :sales, :date, :date
  end
end
