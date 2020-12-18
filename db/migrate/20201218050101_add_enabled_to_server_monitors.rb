class AddEnabledToServerMonitors < ActiveRecord::Migration[6.0]
  def change
    add_column :server_monitors, :enabled, :boolean, default: false
  end
end
