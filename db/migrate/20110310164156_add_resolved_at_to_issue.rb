class AddResolvedAtToIssue < ActiveRecord::Migration
  def self.up
    add_column :issues, :resolved_at, :datetime
  end

  def self.down
    remove_column :issues, :resolved_at
  end
end
