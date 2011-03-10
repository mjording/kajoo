class AddAddressFieldsToReportAndIssue < ActiveRecord::Migration
  def self.up
    add_column :reports, :address, :text
    add_column :reports, :ip_address, :string
    add_column :issues, :ip_address, :string
  end

  def self.down
    remove_column :reports, :ip_address
    remove_column :reports, :address
    remove_column :issues, :ip_address
  end
end
