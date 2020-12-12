class UpdateMonitorsJob < ApplicationJob
  queue_as :default
  require 'uptimerobot'
  after_perform :schedule_update

  def perform(*args)
    client = UptimeRobot::Client.new(api_key: Rails.application.credentials.uptimerobot[:api_key]) 

    uptimeMonitors = client.getMonitors
    
    uptimeMonitors['monitors'].each do |monitor|
      puts "Trying #{monitor['friendly_name']}"

      remote_url = monitor['url']
      if remote_url == 'crewlink.glitch.me' 
        m = ServerMonitor.where(url: 'https://crewlink.glitch.me')
      else
        m = ServerMonitor.where(url: monitor['url'])      
      end

      if m.empty?
        puts "Failed"
      else
        if monitor['status'] == 2
          userCount = /\| (?<count>\w+) users/.match(monitor['friendly_name']) 
          if userCount.nil?
            puts "Couldn't retrieve user count from uptimerobot"
            m.first.update(current_users: 0)
            ActionCable.server.broadcast "landing_channel", 
              content: "#{m.first.name} online, but couldn't retrieve user count", 
              display: true,
              update_html: false,
              updates_users: false,
              id: m.first.id, 
              count: m.first.current_users,
              available: m.first.available,
              official: m.first.official,
              url: m.first.url,
              msg_type: 'warning'
          else
            if m.first.available?
              m.first.update(available: true, current_users: Integer(userCount.captures.first))
              ActionCable.server.broadcast "landing_channel", 
                content: "#{m.first.name} updated. Current users: #{m.first.current_users}", 
                display: false,
                update_html: false,
                update_users: true,
                id: m.first.id, 
                count: m.first.current_users,
                available: m.first.available,
                official: m.first.official,
                url: m.first.url,
                msg_type: 'success'
            else
              m.first.update(available: true, current_users: Integer(userCount.captures.first))
              ActionCable.server.broadcast "landing_channel", 
                content: "#{m.first.name} came online. Current users: #{m.first.current_users}", 
                display: true,
                update_html: true,
                update_users: true,
                id: m.first.id, 
                count: m.first.current_users,
                available: m.first.available,
                official: m.first.official,
                url: m.first.url,
                msg_type: 'success'
            end
          end
        else
          if m.first.available?
            userCount = m.first.current_users
            m.first.update(available: false, current_users: 0)
            ActionCable.server.broadcast "landing_channel", 
              content: "#{m.first.name} went offline with #{userCount} players connected", 
              display: true,
              update_html: true,
              update_users: true,
              id: m.first.id, 
              count: m.first.current_users,
              available: m.first.available,
              official: m.first.official,
              url: m.first.url,
              msg_type: 'error'
          else
            m.first.update(available: false, current_users: 0)
            ActionCable.server.broadcast "landing_channel", 
              content: "#{m.first.name} still offline", 
              display: true,
              update_html: false,
              update_users: false,
              id: m.first.id, 
              count: m.first.current_users,
              available: m.first.available,
              official: m.first.official,
              url: m.first.url,
              msg_type: 'error'
          end
        end
        puts "Success"
      end
    end
  end

  private

  def schedule_update
    UpdateMonitorsJob.set(wait: 5.minutes).perform_later
  end
end
