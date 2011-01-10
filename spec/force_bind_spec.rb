require 'rspec'
require_relative '../ext/force_bind'

describe 'UnboundMethod#force_bind' do
  class Mock
    def the_method
      self
    end
  end

  it 'binds an instance method on a class' do
    Mock.instance_method(:the_method).force_bind(Mock).call.should be Mock
  end

  it 'binds an instance method on an instance of the same class' do
    Mock.instance_method(:the_method).force_bind(mock = Mock.new).call.should be mock
  end

  it 'binds an instance method on an instance of another class' do
    Mock.instance_method(:the_method).force_bind(object = Object.new).call.should be object
  end

  context 'environment' do
    class C
      def initialize(n) @n = n end
      def n; @n end
    end
    class D
      def initialize(n) @n = n end
    end

    it 'refers dynamically to instance variables' do
      C.instance_method(:n).force_bind(D.new(4)).call.should == 4
    end

    it 'refers dynamically to methods' do
      C.send(:define_method, :each) { |&b| (1..@n).each(&b) }
      Enumerable.instance_method(:select).force_bind(C.new(5)).call(&:even?).should == [2,4]
    end

    it 'can transplant methods on instances' do
      (d = D.new(4)).define_singleton_method(:attr_n, &C.instance_method(:n).force_bind(d))
      d.attr_n.should == 4
    end

    it 'can transplant methods on classes with a specific instance' do
      D.send(:define_method, :attr_n, &C.instance_method(:n).force_bind(d = D.new(4)))
      d.attr_n.should == 4
      D.new(:whatever).attr_n.should == 4
    end

    it 'can transplant methods from a class to another by rebinding' do
      class Source
        def steal_me
          [self, @a]
        end
      end
      class Target
        def initialize(a) @a = a end
      end

      steal = lambda do |source_method, target_class, method_name|
        target_class.class_exec do
          define_method(method_name) do |*a,&b|
            source_method.force_bind(self).call(*a,&b)
          end
        end
      end

      target = Target.new(2)
      steal.call(Source.instance_method(:steal_me), Target, :stolen)
      target.stolen.should == [target, 2]
      (t = Target.new(3)).stolen.should == [t, 3]
    end

    it 'can not (yet) bind methods using super on other instances' do
      class Parent
        def meth
          :meth
        end
      end
      class Child < Parent
        def meth
          super
        end
      end

      lambda {
        Child.instance_method(:meth).force_bind(C.new(1)).call
      }.should raise_error(NotImplementedError,
        'super from singleton method that is defined to multiple classes is not supported; this will be fixed in 1.9.3 or later')
    end
  end
end
