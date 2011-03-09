class Issue < ActiveRecord::Base
  has_many :reports

end

# == Schema Information
#
# Table name: issues
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :text
#  lat         :float
#  lon         :float
#  radius      :integer
#  created_at  :datetime
#  updated_at  :datetime
#  report_id   :integer
#

