class AddWinAmountToEppls < ActiveRecord::Migration
  def change
    add_column :eppls, :win_amount, :string
  end
end
