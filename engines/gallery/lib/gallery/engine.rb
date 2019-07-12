# frozen_string_literal: true

module Gallery
  class Engine < ::Rails::Engine
    isolate_namespace Gallery
    config.generators.api_only = true
  end
end
