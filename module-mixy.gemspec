Gem::Specification.new do |gem|
  gem.authors       = ['Kenichi Kamiya']
  gem.email         = ['kachick1+ruby@gmail.com']
  gem.summary       = %q{Struct++}
  gem.description   = %q{Validatable, Inheritable... And more Struct++ features :)}
  gem.homepage      = 'https://github.com/kachick/module-mixy'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features|declared)/})
  gem.name          = 'module-mixy'
  gem.require_paths = ['lib']
  gem.version       = '0.0.1'

  gem.required_ruby_version = '>= 1.9.2'

  gem.add_development_dependency 'declare', '~> 0.0.4'
  gem.add_development_dependency 'yard', '~> 0.8'
end

