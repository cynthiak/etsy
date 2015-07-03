class ChangeFieldTypeInGiveaway < ActiveRecord::Migration
  def up
  	change_column :giveaways, :customer_id, :string
  	rename_column :giveaways, :customer_id, :recipient
  end

  def down
    change_column :giveaways, :customer_id, :integer
    rename_column :giveaways, :recipient, :customer_id
  end
end
