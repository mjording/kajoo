# this class defines types of achievements
class Achievement
    
  attr_accessor :id, :name, :description, :event, :condition
  
  def initialize(opts = {})
    self.id = opts[:id]
    self.name = opts[:name]
    self.description = opts[:description]
    self.event = opts[:event]
    self.condition = opts[:condition]
    
    puts "Saved achievement: #{self.inspect}"
  end
  
  def self.all
    return ACHIEVEMENTS
  end
  
  #available event types:
  # report_saved
  # vote_saved
  # referral
  # issue_closed
  def self.for_event(event)
    achievements = ACHIEVEMENTS.select {|a| return event.to_s == a.event }
    puts "Achievements (in achievement.rb): #{achievements}"
    return achievements
  end
  
end