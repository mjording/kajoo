require 'spec_helper'

describe UserToken do
  it { should belong_to(:user) }
end


# == Schema Information
#
# Table name: user_tokens
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  provider   :string(255)
#  uid        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

