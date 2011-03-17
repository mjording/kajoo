require 'spec_helper'

describe Report do
  it { should belong_to(:issue)}
  it { should belong_to(:user)}
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }


end



# == Schema Information
#
# Table name: reports
#
#  id             :integer(4)      not null, primary key
#  user_id        :integer(4)
#  title          :string(255)
#  description    :text
#  lat            :float
#  lon            :float
#  radius         :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#  issue_id       :integer(4)
#  tags           :string(255)
#  address        :text
#  ip_address     :string(255)
#  location       :text
#  city           :string(255)
#  state          :string(255)
#  country_code   :string(255)
#  country_name   :string(255)
#  street_address :string(255)
#  zipcode        :string(255)
#

