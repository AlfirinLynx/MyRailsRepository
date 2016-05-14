# coding: utf-8
require_relative 'prod_name_module'

class Train
  include ProdName

  NUMBER_FORMAT = /^[0-9а-яa-z]{3}-*[0-9а-яa-z]{2}$/i

  # скорость, число вагонов, номер поезда - к этим параметрам неплохо иметь доступ(чтение) извне
  attr_reader :speed, :name, :number
  @@trains = {} # Хэш для хранения созданных объектов-поездов
  
  
  def self.all
    @@trains
  end

  def self.find(number)
    @@trains[number]
  end



  def initialize(name, number)
    @name = name
    @number = number
    validate!
    @speed = 0
    @waggons = []
    @@trains[number] = self
  end



  ########Методы интерфейса############
  def waggon_block
    return "No block" unless block_given?
    waggons.each { |w| yield w }
  end

  
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
    return "Перед добавлением вагона нужно остановить поезд!" unless speed.zero?
    waggons << waggon
  end

  def delete_waggon(waggon)
    return "Перед отцеплением вагона нужно остановить поезд!" unless speed.zero?
    return "Нет такого вагона в составе!" unless waggons.include? waggon
    waggons.delete(waggon)
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
    puts cur_station ? "Текущая станция: #{cur_station.name}" : "Поезд еще не посещал станций"
  end

  def show_next_station
    return "Для этого поезда маршрут не определен" if route.nil?
    st = route.next_to(cur_station)
    puts st ? "Следующая станция -  #{st.name}" : "Это последняя станция маршрута"
  end

  def show_prev_station
    return "Для этого поезда маршрут не определен" if route.nil?
    st = route.prev_to(cur_station)
    puts st ? "Предыдущая станция -  #{st.name}" : "Это первая станция маршрута"
  end

  protected
  
  attr_accessor :route, :cur_station, :waggons # для показа текущей станции есть свой метод интерфейса, станция может и не существовать до принятия маршрута
  attr_writer :speed # изменять скорость можно только с помощью интерфейса

  # Метод используется вместо константы, устанавливает рабочую скорость поезда
  def usual_speed
    70
  end

  def validate!
    raise "Имя поезда не должно быть пустым" if name.empty?
    raise "Неверный формат номера" if number !~ NUMBER_FORMAT
    true
  end
end
