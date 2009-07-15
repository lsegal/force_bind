require 'mkmf'
$CPPFLAGS += " -DRUBY_19" if RUBY_VERSION =~ /1.9/
ext = 'bind_class'
dir_config(ext)
create_makefile(ext)