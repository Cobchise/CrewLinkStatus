class HomeController < ApplicationController
  def index
    @monitors = ServerMonitor.is_enabled.order! 'name ASC'

    @officialMonitor = ServerMonitor.where(official: true).first
  end
end
