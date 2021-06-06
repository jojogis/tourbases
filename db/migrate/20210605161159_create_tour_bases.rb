class CreateTourBases < ActiveRecord::Migration[5.2]
  def change
    create_table :tour_bases do |t|
      t.string :name
      t.string :description
      t.references :city, foreign_key: true
      t.references :region, foreign_key: true

      t.timestamps
    end
  end
end
