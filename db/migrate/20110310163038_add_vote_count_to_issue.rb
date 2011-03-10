class AddVoteCountToIssue < ActiveRecord::Migration
  def self.up
    add_column :issues, :vote_count, :integer, :nullable => false, :default => 0
  end

  def self.down
    remove_column :issues, :vote_count
  end
end
