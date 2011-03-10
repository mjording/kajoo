require 'spec_helper'

describe Report do
  pending "add some examples to (or delete) #{__FILE__}"
end


# == Schema Information
#
# Table name: reports
#
#  id             :integer         not null, primary key
#  user_id        :integer
#  title          :string(255)
#  description    :text
#  lat            :float
#  lon            :float
#  radius         :integer
#  created_at     :datetime
#  updated_at     :datetime
#  issue_id       :integer
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

