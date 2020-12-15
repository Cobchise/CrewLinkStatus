class UpdateAllServerMonitorsJob < ApplicationJob
  queue_as :default
  after_perform :schedule_update 

  def perform
    schedule_update
  end

  private

  # Schedule an update of all monitors in the db 
  def schedule_update
    ServerMonitor.all.each do |monitor|
      UpdateServerMonitorJob.set(wait: 5.minutes).perform_later(monitor)
    end
  end
end
