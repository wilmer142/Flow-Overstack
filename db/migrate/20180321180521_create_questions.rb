class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :tittle
      t.text :description
      t.integer :votes

      t.timestamps
    end
  end
end
