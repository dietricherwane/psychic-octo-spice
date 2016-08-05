$( document ).ready(function() {
  var partial_cheque_amount = '<%= @cheque_amount %>';
  var partial_paymoney_amount = '<%= @paymoney_amount %>';
  var total_cheque_amount = '<%= @cheque_amount + @paymoney_amount %>';
  var total_paymoney_amount = '<%= 0 %>';
  $('#transaction_type').on('change', function(){
    if($( "#transaction_type" ).val() == 'Paiement total'){
      $('#cheque_amount').val(total_cheque_amount);
      $('#paymoney_amount').val(total_paymoney_amount);
    }
    else{
      $('#cheque_amount').val(partial_cheque_amount);
      $('#paymoney_amount').val(partial_paymoney_amount);
    }
  });
});
