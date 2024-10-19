class ReallyFinalCreateBreweries2 < ActiveRecord::Migration[7.1]
  def change
    create_table :breweries do |t|
      t.string :name
      t.string :bar_type
      t.string :address
      t.string :state
      t.decimal :lat, precision: 8, scale: 6
      t.decimal :long, precision: 9, scale: 6

      t.timestamps
    end
  end
end
