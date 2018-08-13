require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'check create' do
    account = create(:account)
    expect(account).to be_valid 
  end
  context 'check validates' do
    it { is_expected.to validate_presence_of(:name) } 
  end
  context 'check associations' do
    it { is_expected.to belong_to(:account_type) }
    it { is_expected.to belong_to(:person) }
    it { is_expected.to have_one(:group_account) }
    it { is_expected.to have_one(:account_attr) }
  end
end
