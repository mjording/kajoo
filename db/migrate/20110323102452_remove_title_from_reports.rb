class RemoveTitleFromReports < ActiveRecord::Migration
  def self.up
    remove_column :reports, :title
    
  end

  def self.down
    add_column :reports, :title, :string
  end
end
