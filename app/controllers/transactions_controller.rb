class TransactionsController < ApplicationController
    include  ServiceTransaction
    before_action :set_transaction, only: [:show]
    def index
      page_number = params[:page].try(:[], :number)
      per_page    =  params[:page] != nil ? params[:page].try(:[], :size) : 10
      if params[:query]       
        @transactions = Transaction.where(account_id: params[:query]).paginate(:page => page_number, :per_page => per_page)
      else     
        @transactions =   Transaction.all.paginate(:page => page_number, :per_page => per_page)
      end    
      if stale?(@transactions)
        render json: @transactions
      end  
    end
    def show 
      render json: @transaction       
    end
    def create 


      puts "###################################"
      puts transaction_params.to_json
      puts "###################################"
      
      
      type = TransactionType.find_by_id(transaction_params[:transaction_type_id])

        unless type.nil?
          if type.code.eql?("Transferências")
             check = check_transfer(transaction_params[:account_id], transaction_params[:account_receive])
             if check
              @transaction =   Transaction.new(transaction_params)
              if @transaction.save
                render json: @transaction, status: :created, location: @transaction
              else
                render json: ErrorSerializer.serialize(@transaction.errors), status: :unprocessable_entity
              end
             else
                render json: {errors: {id:"account_receive",
                           tittle:"operação não pode ser realizada"}}.to_json,status: :unprocessable_entity
             end
          else
            @transaction = Transaction.new
            @transaction.account_id = transaction_params[:account_id]
            @transaction.transaction_type_id = transaction_params[:transaction_type_id]
            @transaction.value = transaction_params[:value]
            @transaction.code = Base64.encode64(transaction_params.to_json)
            if @transaction.save
              render json: @transaction, status: :created, location: @transaction
            else
              render json: ErrorSerializer.serialize(@transaction.errors), status: :unprocessable_entity
            end
          end  
        else
          render json: {errors:{id:"account_receive",
                       tittle:"operação não pode ser realizada"}}.to_json,status: :unprocessable_entity
        end

    
    end
    private
    def set_transaction
      @transaction = Transaction.find_by_id(params[:id])                     
    end   
    def transaction_params
      puts params
     #params.require(:account).permit(:name,:date,:active,:person_id,:account_type_id)
     ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
