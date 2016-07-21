class AddNestedToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :lft,       :integer
    add_column :categories, :rgt,       :integer
  end
end
