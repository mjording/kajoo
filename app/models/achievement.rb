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
    #reports
    Achievement.new({:id => 'submit_first_report', 
                     :name => 'Newbie', 
                     :description => '1st report',
                     :event => 'report_saved',
                     :condition => lambda {|user| user.reports.size == 1}
                    }),
    Achievement.new({:id => 'submit_fifth_report', 
                     :name => 'Hometown Hero', 
                     :description => '5th report',
                     :event => 'report_saved',
                     :condition => lambda {|user| user.reports.size == 5}
                    }),
    Achievement.new({:id => 'submit_thirtieth_report', 
                     :name => 'Local Legend', 
                     :description => '30th report',
                     :event => 'report_saved',
                     :condition => lambda {|user| user.reports.size == 30}
                    }),
    #votes                    
    Achievement.new({:id => 'submit_first_vote', 
                     :name => 'In the Game', 
                     :description => '1st vote',
                     :event => 'vote_saved',
                     :condition => lambda {|user| user.votes.size == 1}
                    }),
    Achievement.new({:id => 'submit_twentyfifth_vote', 
                     :name => 'Captain of Democracy', 
                     :description => '25th vote',
                     :event => 'vote_saved',
                     :condition => lambda {|user| user.votes.size == 25}
                    }),
    Achievement.new({:id => 'submit_fiftieth_vote', 
                     :name => 'El Presidente', 
                     :description => '50th vote',
                     :event => 'vote_saved',
                     :condition => lambda {|user| user.votes.size == 50}
                    })
  ]

end