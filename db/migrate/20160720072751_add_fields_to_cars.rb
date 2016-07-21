class AddFieldsToCars < ActiveRecord::Migration
  def change
    add_column :cars, :year, :integer
    add_column :cars, :color, :string
  end
end
