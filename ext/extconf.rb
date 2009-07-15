require 'mkmf'
$CPPFLAGS += " -DRUBY_19" if RUBY_VERSION =~ /1.9/
ext = 'force_bind'
dir_config(ext)
create_makefile(ext)