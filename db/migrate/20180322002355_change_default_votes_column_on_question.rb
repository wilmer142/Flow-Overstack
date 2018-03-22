class ChangeDefaultVotesColumnOnQuestion < ActiveRecord::Migration[5.0]
  def change
  	change_column :questions, :votes, :integer, default: 0 
  end
end
