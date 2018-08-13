module ServiceTransaction
    def check_transfer(account, account2)
        acc  = Account.find_by_id(account)
        acc2 = Account.find_by_id(account2)
        
        if acc.nil? or acc2.nil?
            return false
        else
           if acc2.active
             if acc2.account_type.code.to_s.eql?("Matriz")
                return false
             else
               if acc2.account_attr.account_id.eql?(acc.id)
                  return true
               else
                 result = false
                 AccountAttr.where(account_id: acc.id).each do |attr|
                   if attr.group_account_id.eql?(acc2)
                       result = true
                   end
                 end
                 return result
               end                 
             end
           end
        end
    end    
end