# frozen_string_literal: true

module Gallery
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
