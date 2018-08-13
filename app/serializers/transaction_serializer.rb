class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :account_id, :transaction_type_id, :value, :account_receive,:code
end
