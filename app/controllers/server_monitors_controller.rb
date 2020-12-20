class ServerMonitorsController < ApplicationController
    before_action :set_monitor, only: [:show, :update, :update_monitor, :edit, :destroy]
    before_action :set_server_types, only: [:new, :create, :edit, :update]
    before_action :set_regions, only: [:new, :create, :edit, :update]
    before_action :authenticate_user!

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
        if @monitor.update(monitor_params) 
            flash[:success] = 'Server Monitor successfully updated'
            redirect_to dashboard_index_path
        else
            flash[:error] = "Server Monitor creation failed: #{@monitor.errors.full_messages[0]}"
            render :edit 
        end
    end

    def destroy
        @monitor.destroy
        flash[:success] = "Successfully removed #{@monitor.name}"
        redirect_to dashboard_index_path
    end

    def update_monitor
        @monitor.update_monitor

        # TODO: Add more robust error handling here. Catch instances where .update_monitor returns errors
        flash[:success] = "Successfully pinged #{@monitor.name}"
        redirect_to dashboard_index_path
    end

    private

    def monitor_params 
        params.require(:server_monitor).permit(:name, :url, :description, :enabled, :region, :official)
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
