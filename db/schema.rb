# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170309102604) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administrators", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phone_number"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.boolean  "published"
  end

  add_index "administrators", ["email"], name: "index_administrators_on_email", unique: true, using: :btree
  add_index "administrators", ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true, using: :btree

  create_table "ail_loto_logs", force: true do |t|
    t.string   "operation"
    t.string   "transaction_id"
    t.text     "sent_params"
    t.text     "response_body"
    t.string   "remote_ip_address"
    t.string   "error_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ail_lotos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "operation"
    t.string   "transaction_id"
    t.string   "message_id"
    t.string   "confirm_id"
    t.string   "date_time"
    t.string   "bet_code"
    t.string   "bet_modifier"
    t.string   "selector1"
    t.string   "selector2"
    t.string   "repeats"
    t.string   "special_count"
    t.string   "normal_count"
    t.string   "entries"
    t.string   "special_entries"
    t.string   "normal_entries"
    t.string   "response_status"
    t.string   "response_date_time"
    t.string   "response_data_name"
    t.string   "response_error_code"
    t.text     "response_error_message"
    t.string   "ticket_number"
    t.string   "ref_number"
    t.string   "audit_number"
    t.string   "bet_cost_amount"
    t.string   "bet_payout_amount"
    t.string   "response_bet_code"
    t.string   "response_bet_modifier"
    t.string   "response_selector1"
    t.string   "response_selector2"
    t.string   "response_repeats"
    t.string   "response_special_entries"
    t.string   "response_normal_entries"
    t.boolean  "refund_acknowledge"
    t.string   "refund_acknowledge_date_time"
    t.boolean  "cancellation_acknowledge"
    t.string   "cancellation_acknowledge_date_time"
    t.boolean  "placement_acknowledge"
    t.string   "placement_acknowledge_date_time"
    t.string   "gamer_id"
    t.string   "paymoney_account_number"
    t.string   "paymoney_transaction_id"
    t.boolean  "bet_placed"
    t.datetime "bet_placed_at"
    t.text     "error_description"
    t.text     "response_body"
    t.integer  "user_id"
    t.boolean  "bet_cancelled"
    t.datetime "bet_cancelled_at"
    t.boolean  "earning_paid"
    t.datetime "earning_paid_at"
    t.string   "cancellation_paymoney_id"
    t.string   "payment_paymoney_id"
    t.string   "error_code"
    t.string   "game_account_token"
    t.string   "draw_id"
    t.string   "paymoney_validation_id"
    t.string   "paymoney_account_token"
    t.string   "earning_amount"
    t.string   "refund_amount"
    t.boolean  "refund_paid"
    t.datetime "refund_paid_at"
    t.string   "paymoney_earning_id"
    t.string   "paymoney_refund_id"
    t.boolean  "bet_validated"
    t.datetime "bet_validated_at"
    t.boolean  "earning_notification_received"
    t.datetime "earning_notification_received_at"
    t.boolean  "refund_notification_received"
    t.datetime "refund_notification_received_at"
    t.boolean  "sms_sent"
    t.text     "sms_content"
    t.string   "sms_id"
    t.string   "sms_status"
    t.string   "begin_date"
    t.string   "end_date"
    t.string   "draw_day"
    t.string   "draw_number"
    t.string   "bet_status"
    t.string   "basis_amount"
    t.string   "bet_date"
    t.datetime "on_hold_winner_paid_at"
  end

  create_table "ail_pmu_logs", force: true do |t|
    t.string   "operation"
    t.string   "transaction_id"
    t.text     "sent_params"
    t.text     "response_body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remote_ip_address"
    t.string   "error_code"
  end

  create_table "ail_pmus", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "operation"
    t.string   "transaction_id"
    t.string   "message_id"
    t.string   "confirm_id"
    t.string   "date_time"
    t.string   "bet_code"
    t.string   "bet_modifier"
    t.string   "selector1"
    t.string   "selector2"
    t.string   "repeats"
    t.string   "special_count"
    t.string   "normal_count"
    t.string   "entries"
    t.string   "special_entries"
    t.string   "normal_entries"
    t.string   "response_status"
    t.string   "response_date_time"
    t.string   "response_data_name"
    t.string   "response_error_code"
    t.text     "response_error_message"
    t.string   "ticket_number"
    t.string   "ref_number"
    t.string   "audit_number"
    t.string   "bet_cost_amount"
    t.string   "bet_payout_amount"
    t.string   "response_bet_code"
    t.string   "response_bet_modifier"
    t.string   "response_selector1"
    t.string   "response_selector2"
    t.string   "response_repeats"
    t.string   "response_special_entries"
    t.string   "response_normal_entries"
    t.string   "refund_acknowledge_date_time"
    t.string   "cancellation_acknowledge_date_time"
    t.string   "placement_acknowledge_date_time"
    t.string   "remote_ip_address"
    t.boolean  "placement_acknowledge"
    t.boolean  "cancellation_acknowledge"
    t.boolean  "refund_acknowledge"
    t.string   "gamer_id"
    t.string   "paymoney_account_number"
    t.string   "paymoney_transaction_id"
    t.boolean  "bet_placed"
    t.datetime "bet_placed_at"
    t.string   "error_description"
    t.text     "response_body"
    t.integer  "user_id"
    t.boolean  "bet_cancelled"
    t.datetime "bet_cancelled_at"
    t.boolean  "earning_paid"
    t.datetime "earning_paid_at"
    t.string   "cancellation_paymoney_id"
    t.string   "payment_paymoney_id"
    t.string   "error_code"
    t.string   "race_id"
    t.string   "draw_id"
    t.string   "game_account_token"
    t.string   "paymoney_validation_id"
    t.string   "paymoney_account_token"
    t.string   "earning_amount"
    t.string   "refund_amount"
    t.boolean  "refund_paid"
    t.datetime "refund_paid_at"
    t.string   "paymoney_earning_id"
    t.string   "paymoney_refund_id"
    t.boolean  "bet_validated"
    t.datetime "bet_validated_at"
    t.boolean  "earning_notification_received"
    t.datetime "earning_notification_received_at"
    t.boolean  "refund_notification_received"
    t.datetime "refund_notification_received_at"
    t.boolean  "sms_sent"
    t.text     "sms_content"
    t.string   "sms_id"
    t.string   "sms_status"
    t.string   "begin_date"
    t.string   "end_date"
    t.string   "starter_horses"
    t.text     "race_details"
    t.string   "bet_status"
    t.string   "bet_date"
    t.datetime "on_hold_winner_paid_at"
    t.boolean  "validation_on_hold"
  end

  create_table "bet_coupons", force: true do |t|
    t.integer  "bet_id"
    t.string   "pal_code"
    t.string   "event_code"
    t.string   "bet_code"
    t.string   "draw_code"
    t.string   "odd"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "begin_date"
    t.string   "teams"
    t.string   "sport"
    t.string   "is_fix"
    t.string   "handicap"
    t.string   "flag_bonus"
    t.string   "amount"
  end

  create_table "bets", force: true do |t|
    t.string   "license_code"
    t.string   "pos_code"
    t.string   "terminal_id"
    t.string   "account_id"
    t.string   "account_type"
    t.string   "transaction_id"
    t.string   "amount"
    t.string   "win_amount"
    t.boolean  "validated"
    t.datetime "validated_at"
    t.string   "ticket_id"
    t.string   "ticket_timestamp"
    t.boolean  "cancelled"
    t.datetime "cancelled_at"
    t.string   "cancellation_timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remote_ip_address"
    t.string   "pn_ticket_status"
    t.string   "pn_amount_win"
    t.string   "pn_timestamp"
    t.string   "pn_transaction_id"
    t.string   "pn_event_ticket_status"
    t.string   "pn_type_result"
    t.string   "pn_winning_value"
    t.string   "pn_winning_position"
    t.string   "pr_transaction_id"
    t.boolean  "pr_status"
    t.string   "payment_status_datetime"
    t.string   "paymoney_transaction_id"
    t.integer  "user_id"
    t.boolean  "bet_placed"
    t.datetime "bet_placed_at"
    t.string   "paymoney_account_token"
    t.string   "error_code"
    t.text     "error_description"
    t.text     "response_body"
    t.boolean  "bet_cancelled"
    t.datetime "bet_cancelled_at"
    t.string   "gamer_id"
    t.string   "game_account_token"
    t.string   "payment_paymoney_id"
    t.boolean  "earning_paid"
    t.datetime "earning_paid_at"
    t.boolean  "sms_sent"
    t.text     "sms_content"
    t.string   "sms_id"
    t.string   "sms_status"
    t.string   "begin_date"
    t.string   "end_date"
    t.string   "formula"
    t.string   "bet_status"
    t.string   "paymoney_account_number"
    t.datetime "on_hold_winner_paid_at"
    t.text     "payback_unplaced_bet_request"
    t.string   "payback_unplaced_bet_response"
    t.boolean  "payback_unplaced_bet"
    t.datetime "payback_unplaced_bet_at"
    t.string   "system_code"
    t.string   "number_of_combinations"
  end

  create_table "bomb_logs", force: true do |t|
    t.string   "sent_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "civilities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cm_logins", force: true do |t|
    t.string   "connection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cm_logs", force: true do |t|
    t.string   "operation"
    t.string   "connection_id"
    t.string   "current_session_id"
    t.string   "current_session_date"
    t.string   "current_session_status"
    t.string   "surrent_session_currency"
    t.string   "current_session_program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "program_id"
    t.string   "program_type"
    t.string   "program_name"
    t.string   "program_date"
    t.string   "program_status"
    t.string   "race_ids"
    t.string   "gamer_id"
    t.string   "login_error_code"
    t.text     "login_error_description"
    t.string   "current_session_error_code"
    t.text     "current_session_error_description"
    t.text     "login_response"
    t.text     "login_request"
    t.text     "current_session_request"
    t.text     "current_session_response"
    t.string   "get_program_error_code"
    t.text     "get_program_error_description"
    t.text     "get_program_error_response"
    t.text     "get_race_request_body"
    t.string   "get_race_code"
    t.text     "get_race_response"
    t.text     "get_bet_request_body"
    t.text     "get_bet_response"
    t.string   "get_bet_id"
    t.text     "get_results_request_body"
    t.text     "get_results_request_response"
    t.string   "get_results_code"
    t.text     "get_dividends_request_body"
    t.text     "get_dividends_response"
    t.string   "get_dividends_code"
    t.text     "get_eval_request"
    t.text     "get_eval_response"
    t.string   "get_eval_code"
    t.text     "sell_ticket_request"
    t.text     "sell_ticket_response"
    t.string   "sell_ticket_code"
    t.text     "notify_session_request_body"
    t.text     "notify_session_request_result"
    t.string   "session_notification_connection_id"
    t.string   "session_notification_session_id"
    t.string   "session_notification_reason"
    t.string   "program_notification_connection_id"
    t.string   "program_notification_program_id"
    t.string   "program_notification_reason"
    t.string   "notify_race_connection_id"
    t.string   "notify_race_program_id"
    t.string   "notify_race_race_id"
    t.string   "notify_race_reason"
    t.text     "notify_race_request_body"
    t.text     "notify_race_response"
  end

  create_table "cm_wagers", force: true do |t|
    t.integer  "cm_id"
    t.string   "bet_id"
    t.string   "nb_units"
    t.string   "nb_combinations"
    t.string   "full_box"
    t.string   "selections_string"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "winner"
  end

  create_table "cms", force: true do |t|
    t.string   "connection_id"
    t.string   "program_id"
    t.string   "race_id"
    t.string   "sale_client_id"
    t.string   "punter_id"
    t.integer  "amount"
    t.string   "scratched_list"
    t.string   "serial_number"
    t.datetime "bet_placed_at"
    t.text     "placement_request"
    t.text     "placement_response"
    t.string   "game_account_token"
    t.string   "paymoney_account_number"
    t.string   "paymoney_account_token"
    t.string   "p_payment_transaction_id"
    t.text     "p_payment_request"
    t.text     "p_payment_response"
    t.string   "payment_error_code"
    t.text     "payment_error_description"
    t.text     "cancel_request"
    t.text     "cancel_response"
    t.boolean  "cancelled"
    t.datetime "cancelled_at"
    t.string   "p_cancellation_id"
    t.string   "suid"
    t.integer  "win_amount"
    t.string   "win_reason"
    t.string   "win_bet_ids"
    t.string   "win_checksum"
    t.text     "p_validation_request"
    t.text     "p_validation_response"
    t.string   "p_validation_id"
    t.boolean  "p_validated"
    t.datetime "p_validated_at"
    t.text     "pay_earning_request"
    t.text     "pay_earning_response"
    t.string   "p_earning_id"
    t.text     "pay_refund_request"
    t.text     "pay_refund_response"
    t.string   "p_refund_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remote_ip"
    t.string   "transaction_id"
    t.string   "bet_identifier"
    t.string   "begin_date"
    t.string   "end_date"
    t.text     "win_request"
    t.text     "win_response"
    t.text     "notify_session_request_body"
    t.text     "notify_session_request_result"
    t.string   "bet_status"
    t.datetime "on_hold_winner_paid_at"
    t.boolean  "sms_sent"
    t.text     "sms_content"
    t.string   "sms_id"
    t.string   "sms_status"
    t.text     "payback_unplaced_bet_request"
    t.string   "payback_unplaced_bet_response"
    t.boolean  "payback_unplaced_bet"
    t.datetime "payback_unplaced_bet_at"
  end

  create_table "creation_modes", force: true do |t|
    t.string   "name"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_payments", force: true do |t|
    t.string   "type"
    t.string   "transaction_id"
    t.string   "ticket_id"
    t.string   "cheque_id"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "identity_number"
    t.float    "cheque_amount"
    t.string   "paymoney_account_number"
    t.float    "paymoney_amount"
    t.text     "winner_paymoney_account_request"
    t.text     "winner_paymoney_account_response"
    t.text     "paymoney_credit_request"
    t.text     "paymoney_credit_response"
    t.boolean  "paymoney_credit_status"
    t.text     "cheque_credit_request"
    t.text     "cheque_credit_response"
    t.boolean  "cheque_credit_status"
    t.text     "payback_request"
    t.text     "payback_response"
    t.boolean  "payback_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "game"
    t.string   "transaction_type"
    t.string   "bet_amount"
    t.string   "bet_placed_at"
    t.string   "payment_type"
  end

  create_table "deposit_logs", force: true do |t|
    t.string   "game_token"
    t.string   "pos_id"
    t.text     "deposit_request"
    t.text     "deposit_response"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session_id"
  end

  create_table "deposits", force: true do |t|
    t.string   "game_token"
    t.string   "pos_id"
    t.string   "agent"
    t.string   "sub_agent"
    t.string   "paymoney_account"
    t.text     "deposit_request"
    t.text     "deposit_response"
    t.string   "deposit_day"
    t.float    "deposit_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "paymoney_request"
    t.text     "paymoney_response"
    t.string   "paymoney_transaction_id"
    t.boolean  "deposit_made"
    t.string   "transaction_id"
  end

  create_table "eppl_games", force: true do |t|
    t.string   "code"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eppls", force: true do |t|
    t.string   "transaction_id"
    t.string   "paymoney_account"
    t.string   "transaction_amount"
    t.boolean  "bet_placed"
    t.datetime "bet_placed_at"
    t.boolean  "earning_paid"
    t.datetime "earning_paid_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "paymoney_transaction_id"
    t.string   "error_code"
    t.text     "error_description"
    t.string   "response_body"
    t.string   "remote_ip"
    t.string   "paymoney_account_token"
    t.string   "earning_transaction_id"
    t.integer  "user_id"
    t.string   "gamer_id"
    t.boolean  "bet_cancelled"
    t.datetime "bet_cancelled_at"
    t.string   "cancellation_paymoney_id"
    t.string   "payment_paymoney_id"
    t.string   "game_account_token"
    t.boolean  "bet_validated"
    t.datetime "bet_validated_at"
    t.string   "paymoney_validation_id"
    t.boolean  "sms_sent"
    t.text     "sms_content"
    t.string   "sms_id"
    t.string   "sms_status"
    t.string   "begin_date"
    t.string   "end_date"
    t.string   "game_id"
    t.string   "paymoney_account_number"
    t.string   "operation"
    t.string   "bet_status"
    t.string   "paymoney_destination_account"
    t.string   "ticket_id"
  end

  create_table "game_tokens", force: true do |t|
    t.string   "description"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "log_requests", force: true do |t|
    t.string   "description"
    t.text     "request"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", force: true do |t|
    t.string   "transaction_type"
    t.string   "checkout_amount"
    t.text     "response_log"
    t.boolean  "status"
    t.string   "agent"
    t.string   "sub_agent"
    t.string   "transaction_id"
    t.string   "fee"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "error_log"
    t.string   "remote_ip_address"
    t.string   "transaction_status"
  end

  create_table "loto_bet_types", force: true do |t|
    t.string   "code"
    t.string   "category"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ludwin_logs", force: true do |t|
    t.string   "operation"
    t.string   "transaction_id"
    t.string   "language"
    t.string   "sport_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "error_code"
    t.text     "response_body"
    t.text     "sent_body"
    t.string   "remote_ip_address"
  end

  create_table "ludwins", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "paymoney_account_number"
  end

  create_table "parameters", force: true do |t|
    t.string   "registration_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reset_password_url"
    t.string   "ail_username"
    t.string   "ail_password"
    t.string   "ail_terminal_id"
    t.string   "paymoney_wallet_url"
    t.float    "sill_amount"
    t.string   "hub_front_office_url"
    t.float    "postponed_winners_paymoney_default_amount"
    t.string   "paymoney_url"
  end

  create_table "pmu_bet_types", force: true do |t|
    t.string   "code"
    t.string   "category"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", force: true do |t|
    t.string   "description"
    t.boolean  "users_list_right"
    t.boolean  "payment_on_hold_right"
    t.boolean  "pmu_plr_right"
    t.boolean  "loto_right"
    t.boolean  "pmu_alr_right"
    t.boolean  "spc_right"
    t.boolean  "eppl_right"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "gamers_list_right"
    t.boolean  "create_profile_right"
    t.boolean  "habilitations_right"
    t.boolean  "create_account_right"
    t.boolean  "list_gamers_right"
    t.boolean  "list_loto_transactions_right"
    t.boolean  "list_pmu_plr_transactions_right"
    t.boolean  "list_spc_transactions_right"
    t.boolean  "list_pmu_alr_transactions_right"
    t.boolean  "list_eppl_transactions_right"
    t.boolean  "list_pmu_plr_on_hold_transactions_transactions_right"
    t.boolean  "list_loto_on_hold_transactions_transactions_right"
    t.boolean  "list_spc_on_hold_transactions_transactions_right"
    t.boolean  "list_pmu_alr_on_hold_transactions_transactions_right"
    t.boolean  "list_pmu_plr_winners_transactions_transactions_right"
    t.boolean  "list_loto_winners_transactions_transactions_right"
    t.boolean  "list_spc_winners_transactions_transactions_right"
    t.boolean  "list_pmu_alr_winners_transactions_transactions_right"
    t.string   "manager"
    t.boolean  "management_right"
  end

  create_table "query_bets", force: true do |t|
    t.integer  "user_id"
    t.integer  "confirm_id"
    t.datetime "op_code"
    t.string   "bet_code"
    t.string   "bet_modifier"
    t.string   "selector1"
    t.string   "selector2"
    t.string   "repeats"
    t.string   "special_count"
    t.string   "normal_count"
    t.string   "entries"
    t.string   "status"
    t.string   "response_message_id"
    t.string   "response_user_id"
    t.string   "response_datetime"
    t.string   "audit_number"
    t.float    "bet_cost_amount"
    t.string   "response_bet_code"
    t.string   "response_bet_modifier"
    t.string   "response_selector1"
    t.string   "response_selector2"
    t.string   "response_repeats"
    t.string   "response_special_count"
    t.string   "response_normal_count"
    t.string   "response_entries"
    t.string   "error_code"
    t.text     "error_message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sexes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spc_terminals", force: true do |t|
    t.integer  "code"
    t.boolean  "busy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "civility_id"
    t.integer  "sex_id"
    t.string   "pseudo"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "password"
    t.date     "birthdate"
    t.integer  "creation_mode_id"
    t.string   "reset_password_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "password_reseted_at"
    t.boolean  "account_enabled"
    t.string   "msisdn",                 limit: 20
    t.string   "uuid"
    t.string   "last_succesful_message"
    t.string   "integer"
    t.string   "paymoney_password"
    t.string   "account_label"
    t.string   "login_status"
    t.datetime "last_connection_date"
    t.string   "paymoney_account"
  end

  add_index "users", ["civility_id"], name: "index_users_on_civility_id", using: :btree
  add_index "users", ["creation_mode_id"], name: "index_users_on_creation_mode_id", using: :btree
  add_index "users", ["sex_id"], name: "index_users_on_sex_id", using: :btree

end
