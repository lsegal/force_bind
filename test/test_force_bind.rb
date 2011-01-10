require 'test/unit'
require_relative '../ext/force_bind'

class Mock
  def the_method; self end
end

class TestForceBind < Test::Unit::TestCase
  def test_force_bind_class
    proc = Mock.instance_method(:the_method).force_bind(Mock)
    assert_equal Mock, proc.call
  end
  
  def test_force_bind_object
    mock = Mock.new
    proc = Mock.instance_method(:the_method).force_bind(mock)
    assert_equal mock, proc.call
  end
  
  def test_force_bind_object_from_other_class
    arr = Array.new
    proc = Mock.instance_method(:the_method).force_bind(arr)
    assert_equal arr, proc.call
  end
end