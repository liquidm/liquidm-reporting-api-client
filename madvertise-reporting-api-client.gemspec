# encoding: UTF-8

Gem::Specification.new do |gem|
  gem.name        = 'madvertise-reporting-api-client'
  gem.version     = '0.1.0'
  gem.date        = '2013-08-13'
  gem.summary     = "madvertise reporting API client"
  gem.description = "This is an example client implementation to access the madvertise reporting API."
  gem.authors     = 'The madvertise team'
  gem.email       = 'tech@madvertise.de'
  gem.homepage    = 'https://github.com/madvertise/madvertise-reporting-api-client'

  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
end
