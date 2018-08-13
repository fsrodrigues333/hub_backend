require 'rails_helper'

RSpec.describe Transaction, type: :model do 
    context 'check validates' do
        it { is_expected.to validate_presence_of(:value) }  
        it{ is_expected.to validate_numericality_of(:value)} 
      end
      context 'check associations' do
        it { is_expected.to belong_to(:account) }
        it { is_expected.to belong_to(:transaction_type) }        
      end
end
