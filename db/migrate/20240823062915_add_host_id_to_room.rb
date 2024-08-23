class AddHostIdToRoom < ActiveRecord::Migration[7.2]
  def change
    add_column :rooms, :host_id, :integer
  end
end
