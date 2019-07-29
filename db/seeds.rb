# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

email_1 = 'pedro123@gmail.com'
email_2 = 'osvaldo@gmail.com'
p 'creating people...'
person_1 = User::Person.find_by(email: email_1)
if person_1.nil?
  person_1 = User::Person.create(name: 'Pedro', email: email_1, birthday: '1989-10-10')
end
person_2 = User::Person.find_by(email: email_2)
if person_2.nil?
  person_2 = User::Person.create(name: 'Osvaldo', email: email_2, birthday: '1986-10-10')
end
p 'creating authors...'
auth_1 = Auth::User.find_by(username: email_1)
if auth_1.nil?
  Auth::User.create(username: email_1, password: '123456', usereable: person_1)
end
auth_2 = Auth::User.find_by(username: email_2)
if auth_2.nil?
  Auth::User.create(username: email_2, password: '123456', usereable: person_2)
end
p 'creating others stuff...'
scope = Gallery::Scope.create(title: 'Scope 1', description: 'Scope 1')
audience = Gallery::Audience.create(name: 'Crianças', description: 'Crianças')
space_type = Gallery::SpaceType.create(title: 'Sala de aula', description: 'Sala de aula com projetor')
general_material = Gallery::GeneralMaterial.create(name: 'Cartolina', description: 'Cartolina para ser usada em atividades')
p 'creating activities...'
Gallery::Activity.create(
  title: 'Atividade Pedro - Osvaldo',
  caption: 'Atividade em sala',
  description: 'primeira atividade em sala de aula',
  motivation: 'Ensinamentos basicos',
  powerful_ideas: 'Ideias',
  products: 'Produtos',
  requirements: 'Inglês ',
  published: true,
  version_history: '1.1',
  copyright: 'rbac',
  space_organization: 'Precisa de projetor para realizar a atividade',
  implementation_steps: 'Primeiramente ler a apostila pagina 1',
  implementation_tips: 'Realizar a atividade durante o dia',
  reflection_assessment: 'Avaliar o comportamento do aluno',
  duration: 'cerca de 30 minutos',
  references: 'Referências bibliograficas',
  scope_ids: [scope.id],
  audience_ids: [audience.id],
  activity_type: 'internal',
  is_abac_author: false,
  inserted_by: person_1.id,
  external_authors: ['Pedro'],
  external_link: 'http://localhost',
  person_ids: [person_1.id, person_2.id],
  space_type_ids: [space_type.id],
  specific_materials: 'Cola e tesoura sem ponta',
  general_materials: [general_material],
  image: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP0Y/hfDwADvwHOEMGxZAAAAABJRU5ErkJggg==',
  inspirations: []
)
Gallery::Activity.create(
  title: 'Atividade Osvaldo',
  caption: 'Atividade em sala',
  description: 'primeira atividade em sala de aula',
  motivation: 'Ensinamentos basicos',
  powerful_ideas: 'Ideias',
  products: 'Produtos',
  requirements: 'Inglês ',
  published: true,
  version_history: '1.1',
  copyright: 'rbac',
  space_organization: 'Precisa de projetor para realizar a atividade',
  implementation_steps: 'Primeiramente ler a apostila pagina 1',
  implementation_tips: 'Realizar a atividade durante o dia',
  reflection_assessment: 'Avaliar o comportamento do aluno',
  duration: 'cerca de 30 minutos',
  references: 'Referências bibliograficas',
  scope_ids: [scope.id],
  audience_ids: [audience.id],
  activity_type: 'internal',
  is_abac_author: false,
  inserted_by: person_2.id,
  external_authors: ['Osvaldo Aurélio'],
  external_link: 'http://localhost',
  person_ids: [person_2.id],
  space_type_ids: [space_type.id],
  specific_materials: 'Cola e tesoura sem ponta',
  general_materials: [general_material],
  image: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP0Y/hfDwADvwHOEMGxZAAAAABJRU5ErkJggg==',
  inspirations: []
)
p '...ok'