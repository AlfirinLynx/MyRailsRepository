# coding: utf-8
class Station

  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    trains << train
    puts "Поезд #{train.name} прибыл на станцию #{name}"
  end

  def list_trains
    if trains.any?
      puts "В данный момент на станции поезда с номерами:"
      trains.each {|t| puts t.name}
    else
      puts "На станции нет поездов в данный момент"
    end
  end

  def list_trains_by_type
    if trains.any?
      pt = 0
      lt = 0
      trains.each do |t| 
	lt += 1 if t.is_a? CargoTrain
	pt += 1 if t.is_a? PassengerTrain
      end
      puts "В данный момент на станции #{lt} грузовых и  #{pt} пассажирских поездов"
      
    else
      puts "Нет поездов на станции в данный момент"
    end
  end

  def send_train(train)
    if trains.include? train
      trains.delete(train)
      puts "Поезд #{train.name} успешно отправлен"
    else
      puts "Нет поезда с таким номером на станции"
    end
  end

  private
  attr_accessor :trains #Массив поездов - для внутреннего использования

end
