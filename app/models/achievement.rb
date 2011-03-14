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
  
  ACHIEVEMENTS = [
    Achievement.new({:id => 'submit_first_report', 
                     :name => 'Newbie', 
                     :description => 'User submits their first report',
                     :event => 'report_saved',
                     :condition => lambda {|user| user.reports.size == 1}
                    }),
    Achievement.new({:id => 'submit_fifth_report', 
                     :name => 'Home-town Hero', 
                     :description => 'User submits their fifth report',
                     :event => 'report_saved',
                     :condition => lambda {|user| user.reports.size == 5}
                    })                    
  ]

end