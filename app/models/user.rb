class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :twiter_id, :avatar_url
  
  def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    puts "** data: #{data.inspect}"
    if user = User.find_by_email("#{data['screen_name']}@twitter.com")
      user
    else # Create an user with a stub password. 
      User.create!(:email => "#{data['screen_name']}@twitter.com", :password => Devise.friendly_token[0,20], :avatar_url => data['profile_image_url'], :name => data['name'], :twitter_id => data['id']) 
    end
  end 

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session[:omniauth]
        logger.error("in new_with_session of user #{data.to_yaml}")
        user.user_tokens.build(:provider => data['provider'], :uid => data['uid']|| data["extra"]["access_token"].ivars["params"]["member_id"])
      end
    end
  end

  def apply_omniauth(omniauth)
    unless omniauth['credentials'].blank?
      user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid']||omniauth['member_id'])
    else
      user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid']||omniauth['member_id'])
    end
  end

  has_many :reports 

end

# == Schema Information
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

