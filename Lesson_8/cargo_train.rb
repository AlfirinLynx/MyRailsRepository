# coding: utf-8
require_relative 'type_setter'
class CargoTrain < Train
  include TypeSetter

  def add_waggon(waggon)
    if waggon.is_a? CargoWaggon
      super(waggon)
    else
      puts "Грузовой поезд может состоять только из грузовых вагонов"
    end
  end

  protected

  # Переопределена рабочая скорость грузового поезда
  def usual_speed
    60
  end
end
