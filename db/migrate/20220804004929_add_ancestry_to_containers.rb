class AddAncestryToContainers < ActiveRecord::Migration[6.0]
  def change
    add_column :containers, :ancestry, :string
    add_index :containers, :ancestry
  end
end
