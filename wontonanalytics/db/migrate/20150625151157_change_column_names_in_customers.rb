class ChangeColumnNamesInCustomers < ActiveRecord::Migration
  def up
    rename_column :customers, :firstname, :first_name
    rename_column :customers, :lastname, :last_name
  end

  def down
    rename_column :customers, :first_name, :firstname
    rename_column :customers, :last_name, :lastname
  end
end
