class ServerMonitorsController < ApplicationController
    before_action :set_monitor, only: [:show, :update, :edit, :destroy]
    before_action :set_server_types, only: [:new, :create, :edit, :update]
    before_action :set_regions, only: [:new, :create, :edit, :update]

    def index
    end

    def show
    end

    def new
        @monitor = ServerMonitor.new
    end

    def create
        @monitor = ServerMonitor.new monitor_params
        
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
    end

    def update
        @monitor = ServerMonitor.new monitor_params

        if @monitor.valid?
            @monitor.save
            flash[:success] = 'Server Monitor successfully updated'
            redirect_to dashboard_index_path
        else
            flash[:error] = "Server Monitor creation failed: #{@monitor.errors.full_messages[0]}"
            render :edit 
        end
    end

    def destroy
        @monitor.destroy
        flash[:success] = "Successfully destroyed #{@monitor.name}"
    end

    def update_monitor
        @monitor.update_monitor

        # TODO: Add more robust error handling here. Catch instances where .update_monitor returns errors
        flash[:success] = "Successfully pinged #{@monitor.name}"
        redirect_to dashboard_index_path
    end

    private

    def monitor_params 
        params.require(:server_monitor).permit(:name, :url, :description, :region, :official)
    end

    def set_monitor
        @monitor = ServerMonitor.find(params[:id])
    end

    def set_server_types
        @server_types = {
            true: 'Official',
            false: 'Community'
        }
    end

    def set_regions
        @regions = {
            'North America': 'North America',
            'Oceania': 'Oceania',
            'Europe': 'Europe'
        }
    end
end
