class AddPointsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :points, :integer, :nullable => false, :default => 0
  end

  def self.down
    remove_column :users, :points
  end
end
