class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :user_tokens
  has_many :reports
  has_many :issues,:foreign_key => "creator_id" 
  has_many :attributed_issues,:class_name => 'Issue', :foreign_key => "attributed_to" 
  has_many :closed_issues,:class_name => 'Issue', :foreign_key => "resolver_id" 


  has_many :solutions
  has_many :votes
  has_many :issue_votes, :class_name => 'IssueVote'
  has_many :solution_votes, :class_name => 'SolutionVote'
  has_many :achievements, :class_name => 'UserAchievement'
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :avatar_url, :twitter_username, :twitter_id
  
  def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    puts "** data: #{data.inspect}"
    if user = User.find_by_twitter_id("#{data['id']}")
      user
    elsif user = User.find_by_email("#{data['id']}@kajoo.org")
      user
    else # Create an user with a stub password. 
      User.create!(:email => "#{data['id']}@kajoo.org", :password => Devise.friendly_token[0,20], :avatar_url => data['profile_image_url'], :name => data['name'], :twitter_id => data['id'], :twitter_username => data['screen_name']) 
    end

    #if user = User.find_by_email("#{data['screen_name']}@twitter.com")
      #user
    #else # Create an user with a stub password. 
      #User.create!(:email => "#{data['screen_name']}@twitter.com", :password => Devise.friendly_token[0,20], :avatar_url => data['profile_image_url'], :name => data['name'], :twitter_id => data['id'], :twitter_username => data['screen_name']) 
    #end
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

  #XXX TODO - cache and/or include in issue list query so we're not issuing bajillions of queries
  def has_voted_for_issue?(issue)
    return IssueVote.where(:issue_id => issue.id, :user_id => self.id).exists?
  end

  #does the user have any remaining votes for today?
  def votes_remaining
    limit = SITE['daily_vote_limit']
    votes_today = self.votes.where('created_at > :one_day_ago', {:one_day_ago => Time.now - 1.day}).count
    return limit - votes_today
  end
  def add_points_for_create(model)
    add_points_for_action(model.send('create_action'))
  end
  def add_points_for_action(action)
    add_points(SITE['points'][action.to_s])
#    available_achievements = Achievement.for_event('vote_saved')

    available_achievements = ACHIEVEMENTS.select {|a| return action.to_s == a.event }

    puts "Achievements: #{available_achievements}"
    
    available_achievements.each do |achievement|
#    available_achievements.each do |achievement|
#    achievements.each do |achievement|
      puts "Checking for achievement '#{achievement.name}'"
      if(!self.has_achieved?(achievement) && achievement[:condition].call(user))
        puts "Achievement is true!"
        self.achieve(achievement)
      else
        puts "Achievement is false"
      end
    end
  end

#  SITE['points']['vote_on_issue']
 
  def has_achieved?(achievement)
    return UserAchievement.where('achievement = :achievement_code and user_id = :user_id', {:achievement_code => achievement.id, :user_id => self.id}).exists?
  end
  
  protected
  
    def achieve(achievement)
      self.achievements.create(:achievement => achievement.id)
    end
  
    def add_points(newpoints)
      self.points += newpoints
    end

    def accreditation_value(supporter_count)
      scale_number = 0.3
      factor = supporter_count / scale_number
      position = (Math.sqrt(8 * factor + 1) -1) / 2
      position * scale_number
    end

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

