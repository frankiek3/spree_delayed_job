routes = lambda do
  namespace :admin do
    resources :delayed_jobs do
      collection do
        #put :delete
        put :retry_job
        put :run_job_now
#, :only => [:index, :create, :run_job_now, :retry_job, :delete, ]
      end
    end

  #match 'delayed_job_admin' => 'delayed_job_admin#index', :as => 'delayed_job_admin', :method => :get
  #match 'delayed_job_admin/restart' => 'delayed_job_admin#restart', :as => 'delayed_job_admin/restart', :method => :get
  #match 'delayed_job_admin/check_status' => 'delayed_job_admin#check_status', :as => 'delayed_job_admin/check_status', :method => :get

  #match 'delayed_job_admin/delete/:id' => 'delayed_job_admin#delete', :as => 'delete_job_delayed_job_admin', :method => :get
  #match 'delayed_job_admin/retry' => 'delayed_job_admin#retry_job', :as => 'retry_job_delayed_job_admin', :method => :put
  #match 'delayed_jobs/run_now' => 'delayed_jobs#run_job_now', :as => 'run_job_now_delayed_jobs', :method => :put

  end
end


if Spree::Core::Engine.respond_to?(:add_routes)
  Spree::Core::Engine.add_routes(&routes)
else
  Spree::Core::Engine.routes.draw(&routes)
end
