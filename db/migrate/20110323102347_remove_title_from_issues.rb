class RemoveTitleFromIssues < ActiveRecord::Migration
  def self.up
    remove_column :issues, :title
    
  end

  def self.down
    add_column :issues, :title, :string
  end
end
