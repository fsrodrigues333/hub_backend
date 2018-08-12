class CreateAccountAttrs < ActiveRecord::Migration[5.2]
  def change
    create_table :account_attrs do |t|
      t.references :group_account, foreign_key: true
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
