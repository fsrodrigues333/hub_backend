class AccountsController < ApplicationController
    before_action :set_account, only: [:show]
    def index
      page_number = params[:page].try(:[], :number)
      per_page    =  params[:page] != nil ? params[:page].try(:[], :size) : 10
      @accounts = Account.all.paginate(:page => page_number, :per_page => per_page)
      if stale?(@accounts)
         render json: @accounts
      end  
    end
    def show
        render json: @account
    end
    def create        
        @account = Account.new(account_params)
        if @account.save
            render json: @account, status: :created, location: @account
        else
            render json: ErrorSerializer.serialize(@account.errors), status: :unprocessable_entity
        end
    end
    def update
        if @account.update(account_params)
            render json: @account
        else
           render json: ErrorSerializer.serialize(@account.errors), status: :unprocessable_entity
        end 
     end
     def destroy 
        @account.destroy
     end
    private
    def set_account
        if params[:id]
           @account = Account.find_by_id(params[:id])
        end              
    end
    def account_params
        puts params
       #params.require(:account).permit(:name,:date,:active,:person_id,:account_type_id)
       ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
end
