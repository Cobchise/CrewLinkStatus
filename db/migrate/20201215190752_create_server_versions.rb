class CreateServerVersions < ActiveRecord::Migration[6.0]
  def change
    create_table :server_versions do |t|
      t.string :name
      t.boolean :latest, default: false

      t.timestamps
    end
  end
end
