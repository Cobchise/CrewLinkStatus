class ServerMonitor < ApplicationRecord
    has_and_belongs_to_many :server_versions
    has_paper_trail only: [:current_users, :enabled]
    validates :name, :url, presence: true 
    validates :name, :url, uniqueness: true
    validates_format_of :url, with: /\Ahttps:\/\/(\w+.){2,4}\z/, message: 'Ensure your url starts with https://' 

    scope :deleted, -> {
        PaperTrail::Version.
            where(event: 'destroy', item_type: 'ServerMonitor'). 
            joins("LEFT JOIN server_monitors ON item_id=server_monitors.id").
            where("server_monitors.id IS NULL"). 
            select("distinct versions.item_id, versions.created_at, *").order('versions.created_at DESC')
    }

    scope :is_enabled, -> {
        ServerMonitor.where(enabled: true)
    }

    scope :is_disabled, -> {
        ServerMonitor.where(enabled: false)
    }

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
            unless data.nil?
                userCount[data.updated_at] = data.current_users
            end
        end
        userCount
    end

    def get_max_usercount_history
        maxUserCount = {}
        self.versions.each do |v|
            temp = v.reify
            unless temp.nil?
                maxUserCount[v.created_at] = temp.current_users
            end
        end

        maxUserCount.empty? ? nil : maxUserCount.group_by_hour_of_day { |k, v| k }.map { |k, v| [k, v.map(&:last).max] }
    end
end
