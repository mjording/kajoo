class AddAddressToIssue < ActiveRecord::Migration
  def self.up
    add_column :issues, :address, :string
  end

  def self.down
    remove_column :issues, :address
  end
end
