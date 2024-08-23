class CreateVotes < ActiveRecord::Migration[7.2]
  def change
    create_table :votes do |t|
      t.integer :value, null: false
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
