class Person < ApplicationRecord
  belongs_to :person_type
  validates :name,:register, presence: true
  validates :name, uniqueness: { scope: :name, message: "Ja existe no sistema" }
  validates :register, uniqueness: { scope: :register, message: "Ja existe no sistema" }
    
  validate :validate_person_type
  

  def validate_person_type
    type = PersonType.find_by_id(self.person_type_id)        
    unless type.nil?
      case type.code.to_s
        when "Pessoa Jurídica"
          if self.name2.nil?
            errors.add(:name2, " não pode ser nulo.")
          end
        when "Pessoa Física"        
          if self.birth_date.nil? 
            errors.add(:birth_date, " não pode ser nulo.")
          end
        else
          errors.add(:person_type_id, " somente aceita o tipo Pessoa Jurídica ou Pessoa Física.")
      end
    else
      errors.add(:person_type_id, " não foi encontrado nenhum tipo.")
    end
  end
end
