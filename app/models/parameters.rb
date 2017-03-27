class Parameters < ActiveRecord::Base

  # Set accessible fields
  attr_accessible :registration_url, :reset_password_url, :ail_username, :ail_password, :ail_terminal_id, :paymoney_wallet_url, :sill_amount, :hub_front_office_url, :postponed_winners_paymoney_default_amount, :paymoney_url, :cm3_server_url, :cm3_hub_notification_url, :cm3_notification_url, :cm3_username, :cm3_password

  validates :sill_amount, numericality: true
  validates :sill_amount, presence: true

end
