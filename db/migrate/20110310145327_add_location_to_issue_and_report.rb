class AddLocationToIssueAndReport < ActiveRecord::Migration
  def self.up
    add_column :issues, :location, :text
    add_column :reports, :location, :text
  end

  def self.down
    remove_column :issues, :location
    remove_column :reports, :location
  end
end
