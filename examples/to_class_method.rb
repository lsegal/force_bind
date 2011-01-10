require File.dirname(__FILE__) + "/../ext/force_bind"

class Foo
  def bar
    puts "I'm inside #{self}"
  end
end

Foo.new.bar

meth = Foo.instance_method(:bar).force_bind(Foo)
meth.call
