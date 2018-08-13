class GroupAccountSerializer < ActiveModel::Serializer
  attributes :id, :account_id
  belongs_to :account
  has_one :account_attr
end
