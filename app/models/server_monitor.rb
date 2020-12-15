class ServerMonitor < ApplicationRecord
    has_and_belongs_to_many :server_versions
    
    def is_updated?
        self.server_versions.exists?(latest: true)
    end

    def update_monitor 
        UpdateServerMonitorJob.perform_now(self)
    end
end
