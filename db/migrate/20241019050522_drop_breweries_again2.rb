class DropBreweriesAgain2 < ActiveRecord::Migration[7.1]
  def change
    drop_table :breweries
  end
end
