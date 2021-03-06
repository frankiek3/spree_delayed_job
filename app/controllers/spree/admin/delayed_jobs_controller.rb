require 'delayed_job'

class Spree::Admin::DelayedJobsController < Spree::Admin::BaseController
  respond_to :html

  def index
    #@jobs = Delayed::Job.all

    if respond_to? 'delayed_job_admin_check_status'
      @status = if params[:current_status].to_s.include?("delayed_job:")
                  if params[:current_status].to_s.include?("running")
                    params[:current_status].to_s.sub("delayed_job", "Status")
                  elsif params[:current_status].to_s.include?("no")
                    "no"
                  end
                end
    end

    @jobs = Delayed::Job.page(params[:page])
    @jobs = @jobs.order("run_at desc")
  end

  def show
    redirect_to :admin_delayed_jobs
  end

  def create
    Delayed::Job.enqueue(SpreeDelayedJob::DelayedRake.new(params[:job]))
    redirect_to :admin_delayed_jobs
  end

  def restart
    delayed_job_admin_restart
    redirect_to :action => 'index', :current_status => @status
  end

  def check_status
    delayed_job_admin_check_status
    redirect_to :action => 'index', :current_status => @status
  end

  def destroy
    if job = Delayed::Job.find(params[:job_id])
      job.destroy
    end
    render :nothing => true
  end

  def delete
    if job = Delayed::Job.find(params[:job_id])
      job.destroy
    end
    redirect_to :action => 'index'
  end

  def run_job_now
    if job = load_by_id
      job.run_at = Time.now
      job.save
    end
    redirect_to :admin_delayed_jobs
  end

  def retry_job
    if job = load_by_id
      job.run_at = Time.now
      job.failed_at = nil
      job.locked_at = nil
      job.locked_by = nil
      job.save
    end
    redirect_to :admin_delayed_jobs
  end

  private

  def load_by_id
    #if mongoid?
    #  Delayed::Job.find(params[:job_id])
    #else
      Delayed::Job.find_by_id(params[:job_id])
    #end
  end

  def mongoid?
    #Delayed::Job.ancestors.include?(Mongoid::Document)
    false
  end

  #def model_class
  #  SpreeDelayedJob
  #end

end
