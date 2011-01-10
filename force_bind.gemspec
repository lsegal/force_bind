SPEC = Gem::Specification.new do |s|
  s.name          = "force_bind"
  s.summary       = "Adds UnboundMethod#force_bind to bind an unbound method to a class (or any object of any type)"
  s.version       = "0.1.1"
  s.date          = "2011-01-09"
  s.author        = "Loren Segal"
  s.email         = "lsegal@soen.ca"
  s.homepage      = "http://github.com/lsegal/force_bind"
  s.files         = %w(Rakefile README ext/force_bind.c ext/method.h ext/extconf.rb test/test_force_bind.rb)
  s.extensions    = ['ext/extconf.rb']
  s.has_rdoc      = false
end