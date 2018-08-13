class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :account, foreign_key: true
      t.references :transaction_type, foreign_key: true
      t.float :value
      t.bigint :account_receive

      t.timestamps
    end
  end
end
