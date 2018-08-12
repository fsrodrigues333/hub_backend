class AccountSerializer < ActiveModel::Serializer
  attributes :id, :name,:date,:active,:person_id,:account_type_id 
  has_one :group_account
  has_one :account_attr, :through => :group_account
end
