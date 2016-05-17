# coding: utf-8
module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      attr_name = "@#{name}".to_sym
      attr_his = "@#{name}_his".to_sym
      define_method(name) { instance_variable_get(attr_name) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(attr_name, value)
        instance_variable_set(attr_his, (instance_variable_get(attr_his) || []) << value)
      end
      define_method("#{name}_history".to_sym) { instance_variable_get(attr_his) }
    end
  end

  def strong_attr_accessor(name, cls)
    attr_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(attr_name) }
    define_method("#{name}=".to_sym) do |value|
      raise ArgumentError, "Wrong type of the right-hand expression: '#{value.class.name}' (must be '#{cls.name}')" unless value.instance_of? cls
      instance_variable_set(attr_name, value)
    end
  end

end

class Test
  extend Accessors
  attr_accessor_with_history :a, :b
  strong_attr_accessor :f, String
  
end

t = Test.new

t.a = 5

t.b = 'a'

t.a = 'cat'

t.b = 7

puts t.a_history # Выведет [ 5, 'cat']
puts t.b_history # Выведет [ 'a', 7 ]

t.f = 'str'
puts t.f # Выводит "str"

t.f = 7 # Выдает исключение - нельзя присвоить переменной f выражение типа Fixnum


