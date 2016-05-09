# coding: utf-8
require_relative 'prod_name_module'

class Train
  include ProdName
  @@trains = {} #Хэш для хранения созданных объектов-поездов
  
  #скорость, число вагонов, номер поезда - к этим параметрам неплохо иметь доступ(чтение) извне
  attr_reader :speed, :name, :number

  NUMBER_FORMAT = /^[0-9а-яa-z]{3}-*[0-9а-яa-z]{2}$/i

  def initialize(name, number)
    @name = name
    @number = number
    validate!
    @speed = 0
    @waggons = []
    @@trains[number] = self
  end

  def self.all
    @@trains
  end

  def self.find(number)
    @@trains[number]
  end


  ########Методы интерфейса############
  def valid?
    validate!
  rescue
    false
  end
  
  def go
    self.speed = usual_speed
  end

  def show_speed
    speed
  end

  def stop
    self.speed = 0
  end

  def waggonage
    waggons.length
  end

  def add_waggon(waggon)
    if speed == 0
      waggons << waggon
    else
      puts "Перед добавлением вагона нужно остановить поезд!"
    end
  end

  def delete_waggon(waggon)
    if speed == 0
      if waggons.include? waggon
        waggons.delete(waggon)
      else
        puts "Нет такого вагона в составе!"
      end
    else
      puts "Перед отцеплением вагона нужно остановить поезд!"
    end
  end

  def accept_route(route)
    self.route = route
    self.cur_station = route.first_station
  end

  def go_to_station(station)
    self.cur_station = station if route && route.station_in_route?(station)
  end

  def go_to_station_by_name(station_name)
    station = route.station_by_name(station_name) if route
    go_to_station(station) #если нет заданного маршрута, то в аргумент функции попадет station = nil, обработка этого случая предусмотрена
  end

  def show_current_station
    if cur_station
      puts "Текущая станция: #{cur_station.name}"
    else
      puts "Поезд еще не посещал станций"
    end
  end

  def show_next_station
    if route
      st = route.next_to(cur_station)
      if st
	puts "Следующая станция -  #{st.name}"
      else
	puts "Это последняя станция маршрута"
      end
    else
      puts "Для этого поезда маршрут не определен"
    end
  end

  def show_prev_station
    if route
      st = route.prev_to(cur_station)
      if st
	puts "Предыдущая станция -  #{st.name}"
      else
	puts "Это самая первая станция маршрута"
      end
    else
      puts "Для этого поезда маршрут не определен"
    end
  end

  protected
  attr_accessor :route, :current_station, :waggons #для показа текущей станции есть свой метод интерфейса, станция может и не существовать до принятия маршрута
  attr_writer :speed #изменять скорость можно только с помощью интерфейса

  #Метод используется вместо константы, устанавливает рабочую скорость поезда
  def usual_speed
    70
  end

  def validate!
    raise "Имя поезда не должно быть пустым" if name.empty?
    raise "Неверный формат номера" if number !~ NUMBER_FORMAT
    true
  end


end
