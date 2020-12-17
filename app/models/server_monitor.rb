class ServerMonitor < ApplicationRecord
    has_and_belongs_to_many :server_versions
    has_paper_trail only: [:current_users]
    validates :name, :url, presence: true 
    validates :name, :url, uniqueness: true
    validates_format_of :url, with: /\Ahttps:\/\/(\w+.){2,4}\z/, message: 'Ensure your url starts with https://' 
    
    def is_updated?
        self.server_versions.exists?(latest: true)
    end

    def update_monitor 
        UpdateServerMonitorJob.perform_now(self)
    end

    def get_usercount_history
        userCount = {}
        self.versions.each do |v|
            data = v.reify 
            userCount[data.updated_at] = data.current_users
        end
        return userCount
    end
end
