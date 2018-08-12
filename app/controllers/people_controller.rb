class PeopleController < ApplicationController
    before_action :set_person, only: [:show, :update,:destroy]
    def index
      page_number = params[:page].try(:[], :number)
      per_page    =  params[:page] != nil ? params[:page].try(:[], :size) : 10
      @people = Person.all.paginate(:page => page_number, :per_page => per_page)

      render json: @people
    end
    def show
      render json: @person
    end
    def create
        @person = Person.new(person_params)
        if @person.save
            render json: @person, status: :created, location: @person
        else
            render json: ErrorSerializer.serialize(@person.errors), status: :unprocessable_entity
        end      
    end
    def update
       if @person.update(person_params)
           render json: @person
       else
          render json: ErrorSerializer.serialize(@person.errors), status: :unprocessable_entity
       end 
    end
    def destroy 
        @person.destroy
    end

    private
    def set_person
        if params[:id]
           @person = Person.find_by_id(params[:id])
        end              
    end
    
    def person_params
        puts params
       #params.require(:person).permit(:name, :register,:name2,:birthdate, :person_type_id)
       ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
end
