# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PersonType.create(code:"Pessoa Jurídica") if PersonType.find_by_code("Pessoa Jurídica").nil? 
PersonType.create(code:"Pessoa Física") if PersonType.find_by_code("Pessoa Física").nil?
AccountType.create(code:"Matriz") if AccountType.find_by_code("Matriz").nil?
AccountType.create(code:"Filial") if AccountType.find_by_code("Filial").nil?
TransactionType.create(code:"Transferências") if TransactionType.find_by_code("Transferências").nil?
TransactionType.create(code:"Aporte") if TransactionType.find_by_code("Aporte").nil?