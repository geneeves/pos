class CreateCashiers < ActiveRecord::Migration
  def change
    create_table :cashiers do |t|
      t.column :name, :string
      t.column :pin, :integer

      t.timestamps
    end
  end
end
