module InstanceCounter
  def self.included(base)
    base.class_variable_set(:@@counter, 0)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      class_variable_get(:@@counter)
    end
  end

  module InstanceMethods
    protected
    def register_instance
      self.class.class_variable_set(:@@counter, self.class.instances+1)
    end
  end
end
