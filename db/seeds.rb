# frozen_string_literal: true

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
  person = User::Person.create(name: 'Pedro', email: email, birthday: '1989-10-10')
end

auth = Auth::User.find_by(username: email)
if auth.nil?
  Auth::User.create(username: email, password: '123456', usereable: person)
end

scope = Gallery::Scope.create(title: 'Scope 1', description: 'Scope 1')
audience = Gallery::Audience.create(name: 'Crianças', description: 'Crianças')
space_type = Gallery::SpaceType.create(title: 'Sala de aula', description: 'Sala de aula com projetor')
general_material = Gallery::GeneralMaterial.create(name: 'Cartolina', description: 'Cartolina para ser usada em atividades')
Gallery::Activity.create(
  title: 'Atividade Inicial',
  caption: 'Atividade em sala',
  description: 'primeira atividade em sala de aula',
  motivation: 'Ensinamentos basicos',
  powerful_ideas: 'Ideias',
  products: 'Produtos',
  requirements: 'Inglês ',
  published: true,
  version_history: '1.1',
  copyright: 'rbac',
  license_type: 'License',
  space_organization: 'Precisa de projetor para realizar a atividade',
  implementation_steps: 'Primeiramente ler a apostila pagina 1',
  implementation_tips: 'Realizar a atividade durante o dia',
  reflection_assessment: 'Avaliar o comportamento do aluno',
  duration: 'cerca de 30 minutos',
  references: 'Referências bibliograficas',
  scope_ids: [scope.id],
  audience_ids: [audience.id],
  person_ids: [person.id],
  space_type_ids: [space_type.id],
  specific_materials: 'Cola e tesoura sem ponta',
  general_materials: [general_material],
  image: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP0Y/hfDwADvwHOEMGxZAAAAABJRU5ErkJggg==',
  inspirations: []
)
