class AddressToText < ActiveRecord::Migration[7.1]
  def change
    change_column :breweries, :address, :text
  end
end
