class WelcomeController < ApplicationController
  SHOW_LIMIT = 10

  def index
    @order = ['latest', 'votes', 'resolved'].include?(params[:order]) ?  params[:order] : 'latest'
    
    if(@order == 'latest')
      @issues = Issue.order('created_at desc').limit(SHOW_LIMIT)
    elsif(@order == 'votes')
      @issues = Issue.all.limit(SHOW_LIMIT)
    elsif(@order == 'resolved')
      @issues = Issue.all.limit(SHOW_LIMIT)
    end
  end

end
