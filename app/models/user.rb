class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
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

end
