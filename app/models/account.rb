class Account < ApplicationRecord
    attr_accessor :father_account
    attr_reader :matrix
    has_and_belongs_to_many :group_account
    has_many :account_attr, :through => :group_account

    validates :name, :date , presence: true
    validate :validate_account

    private
    def validate_account     
      type = AccountType.find_by_id(self.account_type_id)
      unless type.nil?
        case type.code.to_s
        when "Matriz"
            @matrix = true
        when "Filial"
            @matrix = false
            unless @father_account.nil?
               if Account.find_by_id(@father_account).nil?
                errors.add(:person_type_id, " Conta Pai não encontrada")
               end
            else
              errors.add(:account_type_id, "Conta Filial necessario indicar uma conta pai.")
            end
        else
            errors.add(:person_type_id, " somente aceita o tipo Matriz ou Filial.")   
        end
      else
        errors.add(:account_type_id, " não foi encontrado nenhum tipo.")
      end
    end    
    def create_dependent
       if @matrix
         GroupAccount.create(account_id: self.id)
       else
        group = GroupAccount.create(account_id: self.id)
        AccountAttr.create(group_account_id: group.id,account_id:@father_account)
       end 
    end
    def destroy_dependences
        group = GroupAccount.find_by_id(self.id)
        unless group.nil?
            AccountAttr.where(group_account_id: group.id).each do |attr|
                attr.destroy
            end
            AccountAttr.where(account_id: self.id).each do |attr|
                attr.destroy
            end
            group.destroy
        end
    end

    
end
