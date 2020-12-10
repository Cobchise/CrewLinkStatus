class CreateServerMonitors < ActiveRecord::Migration[6.0]
  def change
    create_table :server_monitors do |t|
      t.string :name
      t.string :url
      t.integer :current_users
      t.text :description
      t.boolean :available
      t.datetime :availableSince
      t.string :region
      t.boolean :official

      t.timestamps
    end
  end
end
