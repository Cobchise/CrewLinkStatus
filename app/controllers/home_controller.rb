class HomeController < ApplicationController
  def index
    @monitors = ServerMonitor.all.order! 'name ASC'

    @officialMonitor = ServerMonitor.where(official: true).first
  end
end
