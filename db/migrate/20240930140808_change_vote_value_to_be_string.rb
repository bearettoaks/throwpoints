class ChangeVoteValueToBeString < ActiveRecord::Migration[7.2]
  def change
    change_column :votes, :value, :string
  end
end
