class AddRefFieldsToExpenses < ActiveRecord::Migration[7.0]
  def change
    add_reference :expenses, :author, null: false, foreign_key: { to_table: :users }
    add_reference :expenses, :group, null: false, foreign_key: true
  end
end
