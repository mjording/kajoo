class AddIssueToReport < ActiveRecord::Migration
  def self.up
    add_column :issues, :report_id, :integer
  end

  def self.down
    remove_column :issues, :report_id
  end
end
