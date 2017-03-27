class AddCm3ParametersToParameters < ActiveRecord::Migration
  def change
    add_column :parameters, :cm3_server_url, :string
    add_column :parameters, :cm3_hub_notification_url, :string
    add_column :parameters, :cm3_notification_url, :string
    add_column :parameters, :cm3_username, :string
    add_column :parameters, :cm3_password, :string
  end
end
