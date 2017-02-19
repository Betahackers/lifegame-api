class AddAgeConstraintToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :age_constraint, :integer
  end
end
