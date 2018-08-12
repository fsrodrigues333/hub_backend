class GroupAccount < ApplicationRecord
  belongs_to :account
  has_one :account_attr, :dependent => :destroy
end
