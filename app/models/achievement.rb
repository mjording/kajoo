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
                     :description => 'Submitted 1st report',
                     :event => 'report_saved',
                     :condition => lambda {|user| user.reports.size == 1}
                    }),
    Achievement.new({:id => 'submit_fifth_report', 
                     :name => 'Home-town Hero', 
                     :description => 'Submitted 5th report',
                     :event => 'report_saved',
                     :condition => lambda {|user| user.reports.size == 5}
                    })                    
  ]

end