require 'date'

Gem::Specification.new do |s|
  s.name        = 'git-run'
  s.version     = '0.0.0'
  s.date        = Date.today.to_s
  s.summary     = "git run"
  s.description = "git run runs commands on git revisions"
  s.authors     = ["Jeff Kreeftmeijer"]
  s.email       = 'jeff@kreeftmeijer.nl'
  s.files       = ["lib/git_run.rb"]
  s.executables = ["git-run"]
  s.homepage    = 'https://github.com/jeffkreeftmeijer/git-run'
  s.license     = 'MIT'

  s.add_runtime_dependency 'rugged', '~> 0.23'
  s.add_development_dependency 'minitest', '~> 5.8'
end
