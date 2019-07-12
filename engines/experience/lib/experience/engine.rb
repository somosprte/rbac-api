# frozen_string_literal: true

module Experience
  class Engine < ::Rails::Engine
    isolate_namespace Experience
    config.generators.api_only = true
  end
end
