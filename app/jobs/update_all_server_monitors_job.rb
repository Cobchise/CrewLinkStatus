class UpdateAllServerMonitorsJob < ApplicationJob
  queue_as :default
  after_perform :schedule_update 

  def perform
    ServerMonitor.all.each do |monitor|
      UpdateServerMonitorJob.perform_now(monitor)
    end
  end

  private

  # Schedule an update of all monitors in the db 
  def schedule_update
    UpdateAllServerMonitorsJob.set(wait: 5.minutes).perform_later
  end
end
