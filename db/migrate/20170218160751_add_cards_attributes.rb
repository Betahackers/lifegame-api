class AddCardsAttributes < ActiveRecord::Migration[5.0]
  def change
    change_table :cards do |t|
      t.string :title
      t.string :person
      t.string :image_url

    end
  end
end
