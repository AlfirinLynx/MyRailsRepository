# coding: utf-8
class PassengerTrain < Train

  def add_waggon(waggon)
    if waggon.is_a? PassengerWaggon
      super(waggon)
    else
      puts "Пассажирский поезд может состоять только из пассажирских вагонов"
    end
  end


  protected

  #Переопределена рабочая скорость пассажирского поезда
  def usual_speed
    75
  end
  
end
