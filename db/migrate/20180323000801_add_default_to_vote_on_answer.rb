class AddDefaultToVoteOnAnswer < ActiveRecord::Migration[5.0]
  def change
  	change_column :answers, :votes, :integer, default: 0 
  end
end
