class AddLocationToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :lat, :float
    add_column :users, :lon, :float
  end

  def self.down
    remove_column :users, :lon
    remove_column :users, :lat
  end
end
