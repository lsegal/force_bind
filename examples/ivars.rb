require File.dirname(__FILE__) + '/../ext/force_bind'

class C
  def initialize(n)
    @n = n
  end
  
  def s
    "I am #{self}"
  end
  
  def ivar
    "@n: #{@n.inspect}"
  end
end

class B
  def initialize; @n = 10 end
end

b, c = B.new, C.new(3)

p :C
p c.s
p c.ivar

meth = C.instance_method(:s).force_bind(b)
meth2 = C.instance_method(:ivar).force_bind(b)
p meth.inspect
p :B
p meth.call
p meth2.call