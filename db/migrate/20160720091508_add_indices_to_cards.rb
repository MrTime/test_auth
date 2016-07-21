class AddIndicesToCards < ActiveRecord::Migration
  def change
    add_index :cars, :year
    add_index :cars, :title
  end
end
