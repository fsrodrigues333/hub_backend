class AccountAttrSerializer < ActiveModel::Serializer
  attributes :id,:group_account_id,:account_id
  belongs_to :group_account
  belongs_to :account  
end
