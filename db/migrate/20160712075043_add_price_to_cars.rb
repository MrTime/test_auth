class AddPriceToCars < ActiveRecord::Migration
  def change
    add_money :cars, :price
  end
end
