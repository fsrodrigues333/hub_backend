class PersonSerializer < ActiveModel::Serializer
  attributes :id, :name, :register,:name2,:birth_date, :person_type_id
  belongs_to :person_type
end
