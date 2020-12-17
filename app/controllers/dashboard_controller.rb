class DashboardController < ApplicationController
    before_action :authenticate_user!

    def index
        @search = ServerMonitor.ransack(params[:q])
        @monitors = @search.result.includes(:server_versions)

        @userCountData = {}
        @monitors.each do |m|
            @userCountData[m.name] = m.current_users
        end
    end
end
