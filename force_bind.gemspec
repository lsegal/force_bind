SPEC = Gem::Specification.new do |s|
  s.name          = "force_bind"
  s.summary       = "Adds UnboundMethod#force_bind to bind an unbound method to class (or any object of any type)"
  s.version       = "0.1.0"
  s.date          = "2009-07-15"
  s.author        = "Loren Segal"
  s.email         = "lsegal@soen.ca"
  s.homepage      = "http://github.com/lsegal/force_bind"
  s.files         = %w(Rakefile README ext/force_bind.c ext/extconf.rb test/test_force_bind.rb)
  s.extensions    = ['ext/extconf.rb']
  s.has_rdoc      = 'yard'
  #s.rubyforge_project = 'force_bind'
end