module User
  class Person < ApplicationRecord
    has_many :authors,    class_name: 'Gallery::Author'
    has_many :activities, through: :authors, class_name: 'Gallery::Acitivity'
  end
end
