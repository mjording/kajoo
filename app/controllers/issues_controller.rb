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
  def create
    @issue = Issue.new(params[:issue])
    if @issue.save
      current_user.add_points_for_action(:report_issue)
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
    if(current_user.votes_remaining > 0)
       
      @issue.add_vote_for_user(current_user)
       flash[:notice] = "Thank you - your vote for '#{Profanalyzer.filter(@issue.description).slice(0,30)+'...'}' has been received"
    
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
  end
  def index
    get_issues
  end


  def mark_resolved
    @issue = Issue.find(params[:id])
    if params[:attributed_to]
      @issue.attributed = User.find(params[:attributed_to])
    end
    if params[:solved_with]
      @issue.solution = Solution.find(params[:solved_with])
    end
    @issue.resolver_id = current_user.id
    @issue.resolved = true
          
    if @issue.save
      respond_to do |format|
         flash[:notice] = "Thank you - #{Profanalyzer.filter(@issue.description).slice(0,30)+'...'} has been resolved"

         format.html {  redirect_to(root_path)}
         format.js

      end
      else
         flash[:alert] = "whoa there buddy"
         redirect_to root_path
      end
  end

  def tag_cloud
    @tags = Issue.tag_counts_on(:discovered)
  end
  
  
end
