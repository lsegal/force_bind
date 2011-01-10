require 'mkmf'

$defs << "-DRUBY192_OR_GREATER" if RUBY_VERSION >= "1.9.2"
create_makefile('force_bind')
