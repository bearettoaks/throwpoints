class CreatePlayers < ActiveRecord::Migration[7.2]
  def change
    create_table :players do |t|
      t.string :name, null: false, default: ""
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
