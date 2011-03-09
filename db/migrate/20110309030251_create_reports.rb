class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.float :lat
      t.float :lon
      t.integer :radius

      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end
