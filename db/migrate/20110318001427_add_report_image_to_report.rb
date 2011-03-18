class AddReportImageToReport < ActiveRecord::Migration
  def self.up
    add_column :reports, :report_image, :string
  end

  def self.down
    remove_column :reports, :report_image
  end
end
