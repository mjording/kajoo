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
  
  def self.for_event(event)
    return ACHIEVEMENTS.collect {|a| return event.to_s == a.event }
  end
  
end