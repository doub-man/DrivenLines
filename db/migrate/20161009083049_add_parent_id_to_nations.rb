class AddParentIdToNations < ActiveRecord::Migration[5.0]
  def change
    add_column :nations, :parent_id, :integer
  end
end
