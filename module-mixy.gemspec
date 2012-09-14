Gem::Specification.new do |gem|
  gem.authors       = ['Kenichi Kamiya']
  gem.email         = ['kachick1+ruby@gmail.com']
  gem.summary       = %q{Module.mixy is not Module.mix :)}
  gem.description   = %q{Module.mixy is not Module.mix :)}
  gem.homepage      = 'https://github.com/kachick/module-mixy'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features|declare)/})
  gem.name          = 'module-mixy'
  gem.require_paths = ['lib']
  gem.version       = '0.0.2'

  gem.required_ruby_version = '>= 1.9.2'

  gem.add_development_dependency 'declare', '~> 0.0.5'
  gem.add_development_dependency 'yard', '~> 0.8'
end

