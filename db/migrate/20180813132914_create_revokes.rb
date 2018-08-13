class CreateRevokes < ActiveRecord::Migration[5.2]
  def change
    create_table :revokes do |t|
      t.bigint :transaction_id
      t.bigint :transaction_eq
      t.string :code
      t.boolean :check
      t.timestamps
    end
  end
end
