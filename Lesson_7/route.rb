# coding: utf-8
require_relative 'station'
class Route

  attr_reader :first_station, :last_station, :name
  
  def initialize(name, first_station, last_station)
    @name = name
    @first_station = first_station
    @last_station = last_station
    validate!
    @stations = []
    @stations << first_station
    @stations << last_station
  end

  def valid?
    validate!
  rescue
    false
  end

  def list_stations
    puts "Stations of the route:"
    stations.each { |st| puts st.name}
  end

  #Возвращает объект класса Station по имени станции
  def station_by_name(station_name)
    stations.each { |st| return st if st.name == station_name }
    nil
  end

  def station_in_route?(station)
    stations.include? station
  end

	#Следующая станция по отношению к данной
  def next_to(station)
    if station != stations.last
      stations[stations.index(station) + 1]
    else
      nil
    end
  end

  #Предыдущая станция по отношению к данной
  def prev_to(station)
    if station != stations.first
      stations[stations.index(station) - 1]
    else
      nil
    end
  end



  def add_station(station, position = 1)
    if (1..(stations.length-1)).include? position
      stations.insert(position, station)
    else
      puts "Первая и последняя станции маршрута не могут быть изменены!"
    end
  end

	#Если by_name = true, то удаление станции происходит по ее имени, если нет - по экземпляру класса Station
  def delete_station(station)
    if stations.first == station || stations.last == station
      puts "Первая и последняя станции маршрута не могут быть удалены!"
    elsif station_in_route?(station) == false
      puts "Станции нет в маршруте!"
    else
      stations.delete(station)
    end
  end

  def delete_station_by_name(station_name)
    station = station_by_name(station_name)
    delete_station(station)
  end

  protected
  #Массив объектов класса Station - неинформативен для внешнего пользователя, список станций можно получить с помощью интерфейса
  attr_accessor :stations

  def validate!
    raise "Имя маршрута должно быть непустым" if name.empty?
    raise "Не задана первая станция маршрута" if not first_station.is_a? Station
    raise "Не задана последняя станция маршрута" if not last_station.is_a? Station
    true
  end
  

end

