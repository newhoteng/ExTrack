class RemoveGroupIdFromExpenses < ActiveRecord::Migration[7.0]
  def change
    remove_column :expenses, :group_id
  end
end
