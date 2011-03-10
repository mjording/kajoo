class AddGeoFieldsToReportAndIssue < ActiveRecord::Migration
  def self.up
    add_column :issues, :city, :string
    add_column :issues, :state, :string
    add_column :issues, :country_code, :string
    add_column :issues, :country_name, :string
    add_column :issues, :street_address, :string
    add_column :issues, :zipcode, :string
    add_column :reports, :city, :string
    add_column :reports, :state, :string
    add_column :reports, :country_code, :string
    add_column :reports, :country_name, :string
    add_column :reports, :street_address, :string
    add_column :reports, :zipcode, :string
  end

  def self.down
    remove_column :issues, :zipcode
    remove_column :issues, :street_address
    remove_column :issues, :country_name
    remove_column :issues, :country_code
    remove_column :issues, :state
    remove_column :issues, :city
    remove_column :reports, :zipcode
    remove_column :reports, :street_address
    remove_column :reports, :country_name
    remove_column :reports, :country_code
    remove_column :reports, :state
    remove_column :reports, :city
  end
end
