class HomeController < ApplicationController
  def index
    @monitors = ServerMonitor.all.order! 'current_users DESC'

    @officialMonitor = ServerMonitor.where(official: true).first
  end
end
