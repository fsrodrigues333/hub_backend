class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name
      t.datetime :date
      t.boolean :active
      t.references :person, foreign_key: true
      t.references :account_type, foreign_key: true
      t.timestamps
    end
  end
end
