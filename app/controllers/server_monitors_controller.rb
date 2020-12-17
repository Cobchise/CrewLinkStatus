class ServerMonitorsController < ApplicationController
    def index
    end

    def show
    end

    def new
        @monitor = ServerMonitor.new
        @server_types = {
            true: 'Official',
            false: 'Community'
        }
        @regions = {
            'North America': 'North America',
            'Oceania': 'Oceania',
            'Europe': 'Europe'
        }
    end

    def create
        @monitor = ServerMonitor.new monitor_params
        @server_types = {
            true: 'Official',
            false: 'Community'
        }
        @regions = {
            'North America': 'North America',
            'Oceania': 'Oceania',
            'Europe': 'Europe'
        }
        
        if @monitor.valid?
            @monitor.save
            flash[:success] = 'Server Monitor successfully created'
            redirect_to dashboard_index_path
        else
            flash[:error] = "Server Monitor creation failed: #{@monitor.errors.full_messages[0]}"
            render :new 
        end
    end

    def edit
        @monitor = ServerMonitor.find(params[:id])
    end

    def update
    end

    def destroy
    end

    def update_monitor
        @monitor = ServerMonitor.find(params[:id])
        @monitor.update_monitor

        # TODO: Add more robust error handling here. Catch instances where .update_monitor returns errors
        flash[:success] = "Successfully pinged #{@monitor.name}"
        redirect_to dashboard_index_path
    end

    private

    def monitor_params 
        params.require(:server_monitor).permit(:name, :url, :description, :region, :official)
    end
end
