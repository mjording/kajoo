class AddAttributedToToIssue < ActiveRecord::Migration
  def self.up
    add_column :issues, :attributed_id, :integer
  end

  def self.down
    remove_column :issues, :attributed_id
  end
end
