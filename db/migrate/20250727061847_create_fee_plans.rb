class CreateFeePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :fee_plans do |t|
      t.string :name
      t.integer :amount

      t.timestamps
    end
  end
end
