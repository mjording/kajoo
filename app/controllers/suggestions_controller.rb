class SuggestionsController < ApplicationController

  #XXX TODO: ajax
  def vote
  
    #redirect if not logged in
    unless can? :create, SolutionVote
      flash[:alert] = 'You must be logged in to vote on a solution'
      redirect_to new_user_session_path
    end
  
    @solution = Solution.find(params[:id])
      
    if(SolutionVote.find_by_solution_id_and_user_id(@solution.id, current_user.id))
      flash[:alert] = 'You cannot vote for the same solution twice'
      redirect_to :controller => 'welcome', :action => 'index'
      return
    end
    
    begin
      @solution.add_vote_for_user(current_user)
    rescue Exception => e
      flash[:alert] = 'Sorry: '+e.message
      puts e.backtrace
      redirect_to :controller => 'welcome', :action => 'index'
      return
    end

    flash[:notice] = "Thank you - your vote for solution '#{@solution.title}' has been received"
    
    redirect_to :controller => 'welcome', :action => 'index'
  end
  def new
    @issue = Issue.find(params[:issue_id])
  end
  def index
    @issue = Issue.find(params[:issue_id])
  end
end

