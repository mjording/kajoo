class CreateSolutions < ActiveRecord::Migration
  def self.up
    create_table :solutions do |t|
      t.string :title
      t.integer :user_id
      t.integer :issue_id

      t.timestamps
    end
  end

  def self.down
    drop_table :solutions
  end
end
