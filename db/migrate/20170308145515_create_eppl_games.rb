class CreateEpplGames < ActiveRecord::Migration
  def change
    create_table :eppl_games do |t|
      t.string :code
      t.string :label

      t.timestamps
    end
  end
end
