# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

email = 'pedro123@gmail.com'

person = User::Person.find_by(email: email)
if person.nil?
    person = User::Person.create(name:"Pedro", email: email, birthday:"1989-10-10")
end

auth = Auth::User.find_by(username: email)
if auth.nil?
    Auth::User.create(username: email, password:'123456', usereable:person)
end

Gallery::Scope.create(title: 'Scope 1', description: 'Scope 1')
Gallery::Audience.create(name: 'Crianças', description: 'Crianças')
Gallery::SpaceType.create(title: 'Sala de aula', description: 'Sala de aula com projetor')
Gallery::GeneralMaterial.create(name: 'Cartolina', description: 'Cartolina para ser usada em atividades')
