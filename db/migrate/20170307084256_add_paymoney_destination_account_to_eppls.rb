class AddPaymoneyDestinationAccountToEppls < ActiveRecord::Migration
  def change
    add_column :eppls, :paymoney_destination_account, :string
  end
end
