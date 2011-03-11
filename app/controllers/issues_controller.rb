class IssuesController < ApplicationController


  def show 
    @issue  = Issue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @issue }
    end
    
  end
  #XXX TODO: ajax
  def vote
  
    #redirect if not logged in
    unless (current_user && (can? :create, IssueVote))
      flash[:alert] = 'You must be logged in to vote on an issue'
      
      respond_to do |format|
        format.html { redirect_to new_user_session_path }
        format.js { 
          render :update do |page| 
            page.redirect_to(new_user_session_path)
          end
        }
      end
      
      return
    end
  
    @issue = Issue.find(params[:id])
      
    if(IssueVote.find_by_issue_id_and_user_id(@issue.id, current_user.id))
      flash[:alert] = 'You cannot vote for the same issue twice'
      logger.warn(flash[:alert])

      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { 
          render :update do |page| 
            page.redirect_to(root_path)
          end
        }
      end

      return
    end
    
    begin
      @issue.add_vote_for_user(current_user)
    rescue Exception => e
      flash[:alert] = e.message
      puts e.backtrace
      logger.warn(flash[:alert])
      
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { 
          render :update do |page| 
            page.redirect_to(root_path)
          end
        }
      end
      
      return
    end
    
    flash[:notice] = "Thank you - your vote for '#{@issue.title}' has been received"
    
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
  
end
