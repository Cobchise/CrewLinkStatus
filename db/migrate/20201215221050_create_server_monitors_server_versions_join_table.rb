class CreateServerMonitorsServerVersionsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :server_monitors, :server_versions
  end
end
