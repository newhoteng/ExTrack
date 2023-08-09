class DropJoinTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :expenses_groups
  end
end
