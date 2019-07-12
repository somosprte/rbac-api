# frozen_string_literal: true

module Auth
  class Engine < ::Rails::Engine
    isolate_namespace Auth
    config.generators.api_only = true
    config.autoload_paths << File.expand_path('../../lib', __dir__)

    initializer :auth_configure do
      ActiveSupport.on_load :action_controller do
        ::ActionController::API.class_eval do
          include Auth::Authenticable
          before_action :authenticate
        end
      end
    end
  end
end
