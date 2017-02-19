class CreateEndings < ActiveRecord::Migration[5.0]
  def change
    create_table :endings do |t|
      t.string :reason
      t.string :cause
      t.string :effect
      t.timestamps
    end
  end
end
