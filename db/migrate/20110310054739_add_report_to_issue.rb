class AddReportToIssue < ActiveRecord::Migration
  def self.up
    add_column :reports, :issue_id, :integer
  end

  def self.down
    remove_column :reports, :issue_id
  end
end
