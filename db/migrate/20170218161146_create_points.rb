class CreatePoints < ActiveRecord::Migration[5.0]
  def change
    create_table :points do |t|
      t.references :answer
      t.integer :value
      t.string :slug

      t.timestamps
    end
  end
end
