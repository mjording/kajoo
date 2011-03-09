class Report < ActiveRecord::Base  
  belongs_to :user
  belongs_to :issue
end

# == Schema Information
#
# Table name: reports
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  title       :string(255)
#  description :text
#  lat         :float
#  lon         :float
#  radius      :integer
#  created_at  :datetime
#  updated_at  :datetime
#

