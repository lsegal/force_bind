require 'mkmf'
$CPPFLAGS += " -DRUBY_191" if RUBY_VERSION == "1.9.1"
ext = 'force_bind'
dir_config(ext)
create_makefile(ext)