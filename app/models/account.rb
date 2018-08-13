class Account < ApplicationRecord
    attr_accessor :father_account
    attr_reader :matrix
    has_one :group_account, :dependent => :destroy
    has_one :account_attr, :through => :group_account
    belongs_to :account_type
    belongs_to :person

    validates :name, :date , presence: true
    validates :name, uniqueness: { scope: :name, message: "Ja existe no sistema" }
    validate :validate_account

    after_create :create_dependent
    before_validation :check_update, on: :update

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
    def check_update
        account = Account.find_by_id(self.id)
        unless account.nil?
           if account.account_type_id.to_i != self.account_type_id.to_i
            errors.add(:account_type_id, " Não é permitido mudar o tipo da conta.")
           end
        end
    end
end
