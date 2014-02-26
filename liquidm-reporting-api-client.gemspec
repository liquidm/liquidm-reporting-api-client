# encoding: UTF-8

Gem::Specification.new do |gem|
  gem.name        = 'liquidm-reporting-api-client'
  gem.version     = '0.1.1'
  gem.date        = '2014-02-26'
  gem.summary     = "LiquidM reporting API client"
  gem.description = "This is an example client implementation to access the LiquidM reporting API."
  gem.authors     = 'The LiquidM team'
  gem.email       = 'tech@liquidm.de'
  gem.homepage    = 'https://github.com/liquidm/liquidm-reporting-api-client'

  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
end
