SPEC = Gem::Specification.new do |s|
  s.name          = "bind_class"
  s.summary       = "Adds UnboundMethod#bind_class to bind an unbound method to class"
  s.version       = "0.1.0"
  s.date          = "2009-07-15"
  s.author        = "Loren Segal"
  s.email         = "lsegal@soen.ca"
  s.homepage      = "http://github.com/lsegal/bind_class"
  s.files         = ['bind_class.c', 'extconf.rb', 'Rakefile', 'README']
  s.extensions    = ['extconf.rb']
  s.has_rdoc      = 'yard'
  #s.rubyforge_project = 'bind_class'
end