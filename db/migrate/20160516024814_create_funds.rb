class CreateFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.date :funding_date
      t.string :funding_source
      t.string :funding_description
      t.float :funding_amount
    end
  end
end
