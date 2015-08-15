module Spree::Admin::DelayedJobsHelper

  def format_time(time)
    if time.present?
      #if DelayedJobAdmin.time_zone
      #  time = time.in_time_zone(DelayedJobAdmin.time_zone)
      #end
      time.to_s(:short)
    else
      '-'
    end
  end
  
end
