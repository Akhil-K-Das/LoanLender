class ChangeRoleTypeToIntegerInUsers < ActiveRecord::Migration[7.2]
  def change
    change_column :users, :role, :integer, default: 0
  end
end
