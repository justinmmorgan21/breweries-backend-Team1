class DropBreweries < ActiveRecord::Migration[7.1]
  def change
    drop_table :breweries
  end
end
