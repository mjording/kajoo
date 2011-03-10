class AddTagsToReport < ActiveRecord::Migration
  def self.up
    add_column :reports, :tags, :string
  end

  def self.down
    remove_column :reports, :tags
  end
end
