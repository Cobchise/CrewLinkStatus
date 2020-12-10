class UpdateMonitorsJob < ApplicationJob
  queue_as :default
  require 'uptimerobot'
  after_perform :schedule_update

  def perform(*args)
    # Do something later
    client = UptimeRobot::Client.new(api_key: Rails.application.credentials.uptimerobot[:api_key]) 

    uptimeMonitors = client.getMonitors
    
    uptimeMonitors['monitors'].each do |monitor|
      puts "Trying #{monitor['friendly_name']}"

      remote_url = monitor['url']
      if remote_url == 'crewlink.glitch.me' 
        m = ServerMonitor.where(url: 'https://crewlink.glitch.me')
        if monitor['status'] == 2
          userCount = /\| (?<count>\w+) users/.match(monitor['friendly_name']).captures.first 
          m.first.update(available: true, current_users: Integer(userCount))
        else
          m.first.update(available: false)
        end
        puts "Success"
      else
        m = ServerMonitor.where(url: monitor['url'])      
        if m.empty?
          puts "Failed"
        else
          if monitor['status'] == 2
            userCount = /\| (?<count>\w+) users/.match(monitor['friendly_name']).captures.first 
            m.first.update(available: true, current_users: Integer(userCount))
          else
            m.first.update(available: false)
          end
          puts "Success"
        end
      end
    end
  end

  private

  def schedule_update
    UpdateMonitorsJob.set(wait: 20.minutes).perform_later
  end
end
