class AccountAttr < ApplicationRecord
  belongs_to :group_account
  belongs_to :account
end
