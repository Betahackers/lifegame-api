class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.string :text
      t.string :kind
      t.references :cards

      t.timestamps
    end
  end
end
