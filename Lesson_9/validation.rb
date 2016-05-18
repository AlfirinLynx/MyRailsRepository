# coding: utf-8
module Validation
  def self.included(base)
    base.class_variable_set(:@@valid_hash, {})
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, validator, *args)
      val_hash = class_variable_get(:@@valid_hash)
      # значением по ключу name является хэш типа: {format: /a*-b/, type: Station}, т. е. одному атрибуту можно задать несколько валидаторов
      val_hash[name] ||= {} 
      val_hash[name][validator] = args
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
      val_hash.each do |name, valid_list|
        attr_name = "@#{name}".to_sym
        attr_val = instance_variable_get(attr_name)
        valid_list.each { |validator, args| send "#{validator}_validate".to_sym, attr_val, *args }
      end
      true
    end

    def presence_validate(attr_val, *args)
      raise "Attribute's value shouldn't be nil" if attr_val.nil?
      raise "Attribute's value shouldn't be empty" if attr_val.empty?
    end

    def format_validate(attr_val, *args)
      raise "Wrong format: #{attr_val}" if attr_val !~ args[0]
    end

    def type_validate(attr_val, *args)
      raise "Wrong type:'#{attr_val.class.name}' ('#{args[0].name}' needed)" unless attr_val.instance_of? args[0]
    end
    
  end
end
