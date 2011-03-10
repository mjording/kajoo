class AddResolvedByToIssue < ActiveRecord::Migration
  def self.up
    add_column :issues, :resolver_id, :integer
  end

  def self.down
    remove_column :issues, :resolver_id
  end
end
