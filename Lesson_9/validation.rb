module Validation
  def self.included(base)
    base.class_variable_set(:@@valid_hash, {})
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, *args)
      (class_variable_get(:@@valid_hash))[name] = args
    end
  end

  module InstanceMethods
    def valid?
      validate!
    rescue
      false
    end
    
    protected
    
    def validate!
      val_hash = self.class.class_variable_get(:@@valid_hash)
      val_hash.each do |name, args|
        attr_name = "@#{name}".to_sym
        attr_val = instance_variable_get(attr_name)
        validator = args[0]
        if validator == :presence
          raise "Attribute's value shouldn't be nil" if attr_val.nil?
          raise "Attribute's value shouldn't be empty" if attr_val.empty?
        elsif validator == :format
          raise "Wrong format" if attr_val !~ args[1]
        elsif validator == :type
          raise "Wrong type" unless attr_val.instance_of? args[1]
        else
          raise "Unknown validator"
        end
      end
      true
    end

  end
end
  
 
