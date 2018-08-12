class CreatePersonTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :person_types do |t|
      t.string :code
      t.timestamps
    end
  end
end
