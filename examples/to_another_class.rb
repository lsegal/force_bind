require_relative '../ext/force_bind'

class A
  def foo; self end
end

class B; end

meth = A.instance_method(:foo).force_bind(B.new)
p meth.call
