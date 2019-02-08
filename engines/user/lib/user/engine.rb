module User
  class Engine < ::Rails::Engine
    isolate_namespace User
    config.generators.api_only = true
  end
end
