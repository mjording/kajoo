require 'spec_helper'

describe User do
  it { should validate_presence_of :email }
end




# == Schema Information
#
# Table name: users
#
#  id                   :integer(4)      not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer(4)      default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  avatar_url           :string(255)
#  twitter_id           :integer(4)
#  name                 :string(255)
#  points               :integer(4)      default(0)
#  twitter_username     :string(255)
#

