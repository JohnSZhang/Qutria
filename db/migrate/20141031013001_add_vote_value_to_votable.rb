class AddVoteValueToVotable < ActiveRecord::Migration
  def change
    add_column :votes, :vote_type, :integer
  end
end
