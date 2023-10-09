class RemoveGroupTotalFromGroups < ActiveRecord::Migration[7.0]
  def change
    remove_column :groups, :group_total, :integer
  end
end
