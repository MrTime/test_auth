class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.string :kind, index: true
      t.string :value, index: true
      t.references :car, index: true

      t.timestamps
    end
  end
end
