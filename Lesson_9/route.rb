# coding: utf-8
require_relative 'validation'
require_relative 'station'
class Route
  include Validation
  attr_reader :first_station, :last_station, :name
  validate :name, :presence
  validate :first_station, :type, Station
  validate :last_station, :type, Station

  def initialize(name, first_station, last_station)
    @name = name
    @first_station = first_station
    @last_station = last_station
    validate!
    @stations = []
    @stations << first_station
    @stations << last_station
  end

  def list_stations
    puts 'Stations of the route:'
    stations.each { |st| puts st.name }
  end

  def station_by_name(station_name)
    stations.each { |st| return st if st.name == station_name }
    nil
  end

  def station_in_route?(station)
    stations.include? station
  end

  def next_to(station)
    station != stations.last ? stations[stations.index(station) + 1] : nil
  end

  def prev_to(station)
    station != stations.first ? stations[stations.index(station) - 1] : nil
  end

  def add_station(station, position = 1)
    if (1..(stations.length - 1)).cover? position
      stations.insert(position, station)
    else
      puts "Первая и последняя станции маршрута не могут быть изменены!"
    end
  end

  def delete_station(station)
    return "Первая и последняя станции маршрута не могут быть удалены!" if stations.first == station || stations.last == station
    stations.delete(station) if station_in_route?(station)
  end

  def delete_station_by_name(station_name)
    station = station_by_name(station_name)
    delete_station(station)
  end

  protected

  attr_accessor :stations

end
