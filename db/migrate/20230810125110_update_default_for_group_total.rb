class UpdateDefaultForGroupTotal < ActiveRecord::Migration[7.0]
  def change
    change_column_default :groups, :group_total, 0
  end
end
