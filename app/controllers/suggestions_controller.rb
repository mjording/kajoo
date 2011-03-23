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
      redirect_to :root
      return
    end
    
    if(current_user.votes_remaining > 0)
      @solution.add_vote_for_user(current_user)
      flash[:notice] = "Thank you - your vote for solution '#{@suggestion.description}' has been received"
    
     redirect_to :root
    #controller => 'pages', :action => 'index'
    else 
      flash[:alert] = 'Sorry: '+e.message
      puts e.backtrace
       redirect_to :root
      return
    end

    
  end
  def new
     if(current_user.votes_remaining > 0)

        @issue = Issue.find(params[:issue_id])
        @suggestion = @issue.suggestions.build 
     else
       flash[:alert] = 'Sorry: '+e.message
        puts e.backtrace
        redirect_to :root
        return
    end

  end
  def index
    @issue = Issue.find(params[:issue_id])
  end
  def create
    @issue = Issue.find(params[:issue_id])
    @suggestion = @issue.suggestions.build(params[:solution])
    if @suggestion.save
      @suggestion.add_points_for_user(current_user, @suggestion.create_action)

      flash[:notice] = "Thank you for your suggestion #{@suggestion.description.slice(0,30)+'...'} way to go"
    
      redirect_to :root
      #controller => 'welcome', :action => 'index'

      #respond_to do |format|
        #format.html { redirect_to(issue_solution_url(@issue, @suggestion) ) }
      #end

    else
      redirect_to(@issue)
    end
  end 
end

