# coding: utf-8
module TypeSetter
  def self.included(base)
    type = "грузовой" if base.name == 'CargoTrain' || base.name == 'CargoWaggon'
    type = "пассажирский" if base.name == 'PassengerTrain' || base.name == 'PassengerWaggon'
    base.class_variable_set(:@@type, type)
    base.extend ClassMethods
  end

  module ClassMethods
    def type
      class_variable_get(:@@type)
    end
  end
end
