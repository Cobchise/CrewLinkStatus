class UpdateServerMonitorJob < ApplicationJob
  require 'httparty'
  queue_as :default
  # Retry if HTTParty errors during request. Retry every 5 seconds a maximum of 3 times 
  retry_on HTTParty::Error, wait: 5.seconds, attempts: 3

  # Rescue from exception in which monitor passed to perform is not found in db
  rescue_from(ActiveRecord::RecordNotFound) do |exception|
    # TODO: Change this to log to file
    puts "\n\n**Error: Record not found. #{exception}**\n\n"
  end

  def perform(monitor)
    # Make request to monitor's health endpoint and parse json result. If respone code != 200 puts error
    # TODO: Change this to log to file
    request = HTTParty.get("#{monitor.url}/health")
    if request.code != 200 
      if not monitor.is_updated?
        puts "Monitor out of date"
      else
        puts "Couldn't reach health endpoint"
      end
      
      current_users = 0
    else
      response = JSON.parse(request.body)
      current_users = response["connectionCount"]
    end

    updated_monitor_data = {
      available: request.code == 200 ? true : false,
      current_users: current_users 
    }
    
    # Clone current state of monitor data for later comparison (to allow smarter broadcast messages) then construct hash with updated monitor data
    old_monitor_data = monitor.clone
    
    # Update the monitor in the db with the new monitor data
    monitor.update(updated_monitor_data)

    # Construct hash containing data to be broadcasted to websocket then broadcast
    broadcast_data = determine_broadcast_data(old_monitor_data, updated_monitor_data, monitor)
    ActionCable.server.broadcast "landing_channel", broadcast_data
  end
  
  private

  # Schedule an update of all monitors in the db 
  def schedule_update
    ServerMonitor.all.each do |monitor|
      UpdateServerMonitorJob.set(wait: 5.minutes).perform_later(monitor)
    end
  end

  def determine_broadcast_data(old_monitor_data, updated_monitor_data, monitor)
    # If still online 
    if old_monitor_data[:available] and updated_monitor_data[:available]
      dyn_data = {
        content: "#{monitor.name} updated. Current users: #{monitor.current_users}",
        display: false,
        update_html: false,
        update_users: true,
        msg_type: 'success'
      }
    # If went offline
    elsif old_monitor_data[:available] and not updated_monitor_data[:available] 
      dyn_data = {
        content: "#{monitor.name} went offline with #{old_monitor_data[:current_users]}",
        display: true,
        update_html: true,
        update_users: true,
        msg_type: 'error'
      }
    # If came online
    elsif not old_monitor_data[:available] and updated_monitor_data[:available]
      dyn_data = {
        content: "#{monitor.name} came online. Current users: #{monitor.current_users}",
        display: true,
        update_html: true,
        update_users: true,
        msg_type: 'success'
      }
    # If still offline
    else
      dyn_data = {
        content: "#{monitor.name} still offline",
        display: true,
        update_html: false,
        update_users: false,
        msg_type: 'error'
      }
    end
    
    # Merge constant data with dynamic data and return to broadcaster
    const_data = {
        id: monitor.id,
        count: monitor.current_users,
        available: monitor.available,
        url: monitor.url,
    }

    puts dyn_data.merge(const_data)
    return dyn_data.merge(const_data)
  end
end
