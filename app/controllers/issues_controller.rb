class IssuesController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:show]

  #custom exception handler puts errors in the pop-down flash area
  rescue_from(VoteException) do |e|
    #TODO: Flash something?
    
    flash[:alert] = e.inspect
    logger.error "Error: '#{e.message}'"
    e.backtrace
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { 
        render :update do |page| 
          page.redirect_to(:back)
        end
      }
    end
  end

  def show 
    @issue  = Issue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @issue }
    end
    
  end
  #XXX TODO: ajax
  def vote
    
    @issue = Issue.find(params[:id])
      
    if(IssueVote.find_by_issue_id_and_user_id(@issue.id, current_user.id))
      flash[:alert] = 'You cannot vote for the same issue twice'
      logger.warn(flash[:alert])

      respond_to do |format|
        format.html { redirect_to :back }
        format.js { 
          render :update do |page| 
            page.redirect_to(:back)
          end
        }
      end

      return
    end
    
    #@issue.add_vote_for_user(current_user)
    
    begin
      @issue.add_vote_for_user(current_user)
    rescue Exception => e

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
      
      return
    end
    
    flash[:notice] = "Thank you - your vote for '#{@issue.title}' has been received"
    
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
  
end
