class RenameTittleToQuestion < ActiveRecord::Migration[5.0]
  def change
  	rename_column :questions, :tittle, :title
  end
end
