if @error_code != 0
  json.error code: @error_code, description: @error_description
else
  json.game "LOTO"
  json.bet do
    json.ticket_number @bet.ticket_number rescue nil
    json.ref_number @bet.ref_number rescue nil
    json.transaction_id @transaction_id rescue nil
    json.audit_number @bet.audit_number rescue nil
    json.bet_cost_amount @bet.bet_cost_amount rescue nil
    json.bet_payout_amount @bet.bet_payout_amount rescue nil
    json.bet_code @bet.bet_code rescue nil
    json.bet_modifier @bet.bet_modifier rescue nil
    json.selector1 @bet.selector1 rescue nil
    json.selector2 @bet.selector2 rescue nil
    json.repeats @bet.repeats rescue nil
    json.special_entries "[#{@bet.special_entries}]" rescue nil
    json.normal_entries "[#{@bet.normal_entries}]" rescue nil
    json.basis_amount "#{@bet.basis_amount}" rescue nil
    json.bet_date @ail_loto.bet_date rescue nil
  end
end
