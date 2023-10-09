class ChangeExpenseIdToNullableOnGroups < ActiveRecord::Migration[7.0]
  def change
    change_column_null :groups, :expense_id, true
  end
end
