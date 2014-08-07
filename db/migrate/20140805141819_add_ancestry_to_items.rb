class AddAncestryToItems < ActiveRecord::Migration
  def change
    add_column :items, :ancestry, :string, after: :name
    add_index :items, :ancestry
  end
end
