class AddDescriptionToSolution < ActiveRecord::Migration
  def self.up
    add_column :solutions, :description, :text
  end

  def self.down
    remove_column :solutions, :description
  end
end
