# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

person = User::Person.find_by(email:"flavio@prte.com.br")
if person.nil?
    person = User::Person.create(name:"Flavio", email:"flavio@prte.com.br", birthday:"1989-10-21")
end

auth = Auth::User.find_by(username:"flavio@prte.com.br")
if auth.nil?
    Auth::User.create(username:"flavio@prte.com.br", password:'123456', usereable:person)
end

person_2 = User::Person.find_by(email:"nivaldo@prte.com.br")
if person_2.nil?
    person_2 = User::Person.create(name:"Nivaldo", email:"nivaldo@prte.com.br", birthday:"1989-11-21")
end

auth_2 = Auth::User.find_by(username:"nivaldo@prte.com.br")
if auth_2.nil?
    Auth::User.create(username:"nivaldo@prte.com.br", password:'123456', usereable:person_2)
end