# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'experience/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'experience'
  spec.version     = Experience::VERSION
  spec.authors     = ['PRTE - Tecnologia e Soluções']
  spec.email       = ['contato@prte.com.br']
  spec.homepage    = 'https://www.prte.com.br'
  spec.summary     = 'Experience Manager'
  spec.description = 'All types of user experiences are managed here.'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'active_model_serializers'
  spec.add_dependency 'rails', '~> 5.2.2'

  spec.add_development_dependency 'pg'
end
