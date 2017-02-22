class AddBetStatusToEppls < ActiveRecord::Migration
  def change
    add_column :eppls, :bet_status, :string
  end
end
