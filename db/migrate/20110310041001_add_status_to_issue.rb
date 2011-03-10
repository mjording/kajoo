class AddStatusToIssue < ActiveRecord::Migration
  def self.up
    add_column :issues, :resolved, :boolean
  end

  def self.down
    remove_column :issues, :resolved
  end
end
