class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :transaction_type

  validates :value, presence: true
  validates :value, numericality: true

  after_create :check_transaction

  private 
  def check_transaction
    if TransactionType.find_by_id(self.transaction_type_id).code.eql?("Transferências")
       trans =  Transaction.where("id != ? and account_id =? and account_receive =? and value =? and transaction_type_id =?",
                                  self.id, self.account_id, self.account_receive, self.value,self.transaction_type_id).last
        unless trans.nil?
           code = Base64.encode64("#{self.id} #{trans.id} #{self.value}")          
          if (self.created_at - trans.created_at).to_i <= 120
              Revoke.create(transaction_id: self.id, transaction_eq: trans.id, code:code, check:false)  
          end        
        end
    else
      trans =  Transaction.where("id != ? and account_id =? and  value =? and transaction_type_id =?",
        self.id, self.account_id, self.value,self.transaction_type_id).last
        unless trans.nil?
          code = Base64.encode64("#{self.id} #{trans.id} #{self.value}")
         if (self.created_at - trans.created_at).to_i <= 120
             Revoke.create(transaction_id: self.id, transaction_eq: trans.id, code:code, check:false)  
         end        
       end
    end
  end
end
