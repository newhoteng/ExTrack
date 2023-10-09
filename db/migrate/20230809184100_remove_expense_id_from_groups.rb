class RemoveExpenseIdFromGroups < ActiveRecord::Migration[7.0]
  def change
    remove_column :groups, :expense_id
  end
end
