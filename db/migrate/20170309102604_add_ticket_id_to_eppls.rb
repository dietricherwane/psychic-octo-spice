class AddTicketIdToEppls < ActiveRecord::Migration
  def change
    add_column :eppls, :ticket_id, :string
  end
end
