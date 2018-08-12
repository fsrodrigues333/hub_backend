class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name
      t.string :register
      t.string :name2
      t.datetime :birth_date
      t.references :person_type, foreign_key: true
      t.timestamps
    end
  end
end
