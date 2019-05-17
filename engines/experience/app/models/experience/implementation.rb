module Experience
  class Implementation < ApplicationRecord
    belongs_to :person, class_name: "User::Person"
    belongs_to :activity, class_name: "Gallery::Activity"
  end
end
