class ReportsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:show]
  
  # GET /reports/1
  # GET /reports/1.xml
  def show
    @report = Report.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @report }
    end
  end

  # GET /reports/new
  # GET /reports/new.xml
  def new
    if(current_user.votes_remaining > 0)
       
    @report = Report.new
    @issue_id = params[:issue]
    if(@issue_id)
      @issue = Issue.find(params[:issue])
    end
#@issues = case params[:order] 
                #when 'votes' then Issue.page(params[:page]||'1').order('vote_count desc')
                #when 'resolved' then Issue.where(:resolved => true).page(params[:page]||'1').order('resolved_at desc')
                #when 'near' then Issue.near(site_location, site_radius).page(params[:page]||'1')
                #else Issue.near(site_location, site_radius).page(params[:page]||'1')
               #end
       @issues = Issue.near(site_location, site_radius).page(params[:page]||'1')
      #@order = ['latest', 'votes', 'resolved', 'near', 'trending'].include?(params[:order]) ?  params[:order] : 'latest'
   
      #@issues = params[:order] ? Issue.fetch_issues( params[:order]).page(params[:page]).per(5)   : Issue.fetch_issues.page(params[:page]).per(5)  

      puts "XHR: #{request.xhr?}"

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @report }
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

  # GET /reports/1/edit
  def edit
    @report = Report.find(params[:id])
  end

  # POST /reports
  # POST /reports.xml
  def create
    #params[:report][:updated_by] = current_user
    
    @report = Report.new(params[:report])

    if(!(params[:issue_id].nil? || params[:issue_id] == ''))
      @report.issue = Issue.find(params[:issue_id])
    end

    @report.user = current_user
    @similar_issues = Issue.find_similar(@report)
    respond_to do |format|
      if @report.save
        format.html { 
          if(@report.issue)
            redirect_to(@report.issue, :notice => 'Report was successfully created.') 
          else
            redirect_to(@report, :notice => 'Report was successfully created.') 
          end
        }
        format.xml  { render :xml => @report.issue, :status => :created, :location => @report }
      else
        format.html { 
 #@issues = case params[:order] 
                #when 'votes' then Issue.page(params[:page]||'1').order('vote_count desc')
                #when 'resolved' then Issue.where(:resolved => true).page(params[:page]||'1').order('resolved_at desc')
                #when 'near' then Issue.near(site_location, site_radius).page(params[:page]||'1')
                #else Issue.near(site_location, site_radius).page(params[:page]||'1')
               #end
     @issues = Issue.near(site_location, site_radius).page(params[:page]||'1')
        errors = 'Your report could not be saved: <ul>'
          @report.errors.each do |field, error|
            errors += "<li>#{field} #{error}</li>"
          end
          errors += '</ul>'
          puts "Your report could not be saved: #{@report.errors.inspect}"
          flash[:alert] = errors
          redirect_to :action => 'new'
        }
        format.xml  { render :xml => @report.errors, :status => :unprocessable_entity }
        format.json  { flash[:alert] = "Your report could not be saved: #{@report.errors.inspect}" }
      end
    end
  end

  # PUT /reports/1
  # PUT /reports/1.xml
  def update
    params[:report][:updated_by] = current_user
    @report = Report.find(params[:id])

    respond_to do |format|
      if @report.update_attributes(params[:report])
        format.html { redirect_to(@report, :notice => 'Report was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.xml
  def destroy
    params[:updated_by] = current_user
    @report = Report.find(params[:id])
    @report.destroy

    respond_to do |format|
      format.html { redirect_to(reports_url) }
      format.xml  { head :ok }
    end
  end
end
