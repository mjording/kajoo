class IssuesController < ApplicationController

  #XXX TODO: ajax
  def vote
  
    #redirect if not logged in
    unless can? :create, IssueVote
      flash[:alert] = 'You must be logged in to vote on an issue'
      redirect_to new_user_session_path
    end
  
    @issue = Issue.find(params[:id])
      
    if(IssueVote.find_by_issue_id_and_user_id(@issue.id, current_user.id))
      flash[:alert] = 'You cannot vote for the same issue twice'
      logger.warn(flash[:alert])
      redirect_to :controller => 'welcome', :action => 'index'
      return
    end
    
    begin
      @issue.add_vote_for_user(current_user)
    rescue Exception => e
      flash[:alert] = 'Sorry: '+e.message
      logger.warn(flash[:alert])
      redirect_to :controller => 'welcome', :action => 'index'  
      return
    end
    
    flash[:notice] = "Thank you - your vote for '#{@issue.title}' has been received"
    redirect_to :controller => 'welcome', :action => 'index'
  end
  
end
