class ApplicationController < ActionController::Base
  has_mobile_fu
  
  #helper_method :is_mobile_device?

#  def is_mobile_device?
#    return true
#  end

  protect_from_forgery

  #rescue_from(Exception) do |e|
    ##TODO: Flash something?
    #flash[:alert] = e.message
    #logger.error "Error: '#{e.message}'"
    
    ##respond_to do |format|
      ##format.html { redirect_to :back }
      ##format.js { 
        ##render :update do |page| 
          ##page.redirect_to(:back)
        ##end
      ##}
    ##end
  #end

  protected

  SHOW_LIMIT = 10

  #the issues list from the front page and several other pages 
  def fetch_issues  
    @order = ['latest', 'votes', 'resolved'].include?(params[:order]) ?  params[:order] : 'latest'
    if(@order == 'latest')
      @issues = Issue.order('created_at desc').limit(SHOW_LIMIT)
    elsif(@order == 'votes')
      @issues = Issue.order('vote_count desc').limit(SHOW_LIMIT)
    elsif(@order == 'resolved')
      @issues = Issue.where(:resolved => true).order('resolved_at desc').limit(SHOW_LIMIT)
    end
    @issues ||= Issue.all
  end
end
