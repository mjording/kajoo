class SolutionsController < ApplicationController

  #XXX TODO: ajax
  def vote
  
    #redirect if not logged in
    unless can? :create, ReportVote
      flash[:alert] = 'You must be logged in to vote on a solution'
      redirect_to new_user_session_path
    end
  
    @solution = Solution.find(params[:id])
      
    if(SolutionVote.find_by_solution_id_and_user_id(@solution.id, current_user.id))
      flash[:alert] = 'You cannot vote for the same solution twice'
      redirect_to :controller => 'welcome', :action => 'index'
      return
    end
     if(current_user.votes_remaining > 0)
       
      @solution.add_vote_for_user(current_user)
       flash[:notice] = "Thank you - your vote for '#{truncate(@solution.description,:length => 30)}' has been received"
    
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:alert] = e.inspect
      puts e.backtrace
      logger.warn(flash[:alert])
      respond_to do |format|
        format.html { 
          if(request.env["HTTP_REFERER"])
            redirect_to :back 
          end
        }
        format.js { 
          render :update do |page| 
            if(request.env["HTTP_REFERER"])
              page.redirect_to(:back)
            end
          end
        }
      end
    end

    #begin
      #@solution.add_vote_for_user(current_user)
    #rescue Exception => e
      #flash[:alert] = 'Sorry: '+e.message
      #puts e.backtrace
      #redirect_to :controller => 'welcome', :action => 'index'
      #return
    #end

    flash[:notice] = "Thank you - your vote for solution #{@solution.description.slice(0,30)+'...'} has been received"
    
    redirect_to root_path
  end
  def new
    @issue = Issue.find(params[:issue_id])
    @suggestion = @issue.suggestions.build  
  end
  def index
    @issue = Issue.find(params[:issue_id])
  end
  def create
    @solution = Solution.new(params[:solution])
    if @solution.save
       @solution.add_points_for_user(current_user, @solution.create_action)

      flash[:notice] = "Thank you for your suggestion #{@solution.description.slice(0,30)+'...'} way to go"
      redirect_to :root
    else
      flash[:notice] = "sorry couldnt save #{@solution.description.slice(0,30)+'...'} "
      redirect_to :root
     end
  end

end
