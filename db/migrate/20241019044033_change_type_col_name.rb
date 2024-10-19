class ChangeTypeColName < ActiveRecord::Migration[7.1]
  def change
    rename_column :breweries, :type, :bar_type
  end
end
