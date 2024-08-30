class AddHostIdToRoom < ActiveRecord::Migration[7.2]
  def change
    add_reference :rooms, :host, foreign_key: { to_table: :players, on_delete: :nullify }, null: true
  end
end
