class AddCreatorToIssue < ActiveRecord::Migration
  def self.up
    add_column :issues, :creator_id, :integer
  end

  def self.down
    remove_column :issues, :creator_id
  end
end
