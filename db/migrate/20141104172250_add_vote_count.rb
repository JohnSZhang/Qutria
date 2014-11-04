class AddVoteCount < ActiveRecord::Migration
  def change
    add_column :questions, :meta_vote_count, :integer
    add_column :answers, :meta_vote_count, :integer 
  end
end
