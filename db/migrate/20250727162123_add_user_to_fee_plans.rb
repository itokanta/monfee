class AddUserToFeePlans < ActiveRecord::Migration[6.0]
  def change
    add_reference :fee_plans, :user, null: true, foreign_key: true
  end
end
