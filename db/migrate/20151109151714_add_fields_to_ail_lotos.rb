class AddFieldsToAilLotos < ActiveRecord::Migration
  def change
    add_column :ail_lotos, :operation, :string
    add_column :ail_lotos, :transaction_id, :string
    add_column :ail_lotos, :message_id, :string
    add_column :ail_lotos, :confirm_id, :string
    add_column :ail_lotos, :date_time, :string
    add_column :ail_lotos, :bet_code, :string
    add_column :ail_lotos, :bet_modifier, :string
    add_column :ail_lotos, :selector1, :string
    add_column :ail_lotos, :selector2, :string
    add_column :ail_lotos, :repeats, :string
    add_column :ail_lotos, :special_count, :string
    add_column :ail_lotos, :normal_count, :string
    add_column :ail_lotos, :entries, :string
    add_column :ail_lotos, :special_entries, :string
    add_column :ail_lotos, :normal_entries, :string
    add_column :ail_lotos, :response_status, :string
    add_column :ail_lotos, :response_date_time, :string
    add_column :ail_lotos, :response_data_name, :string
    add_column :ail_lotos, :response_error_code, :string
    add_column :ail_lotos, :response_error_message, :text
    add_column :ail_lotos, :ticket_number, :string
    add_column :ail_lotos, :ref_number, :string
    add_column :ail_lotos, :audit_number, :string
    add_column :ail_lotos, :bet_cost_amount, :string
    add_column :ail_lotos, :bet_payout_amount, :string
    add_column :ail_lotos, :response_bet_code, :string
    add_column :ail_lotos, :response_bet_modifier, :string
    add_column :ail_lotos, :response_selector1, :string
    add_column :ail_lotos, :response_selector2, :string
    add_column :ail_lotos, :response_repeats, :string
    add_column :ail_lotos, :response_special_entries, :string
    add_column :ail_lotos, :response_normal_entries, :string
    add_column :ail_lotos, :refund_acknowledge, :boolean
    add_column :ail_lotos, :refund_acknowledge_date_time, :string
    add_column :ail_lotos, :cancellation_acknowledge, :boolean
    add_column :ail_lotos, :cancellation_acknowledge_date_time, :string
    add_column :ail_lotos, :placement_acknowledge, :boolean
    add_column :ail_lotos, :placement_acknowledge_date_time, :string
  end
end