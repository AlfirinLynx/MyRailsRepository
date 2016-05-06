# coding: utf-8
require_relative 'station'
class RailwayStation < Station
  @@station_list = [] #Будут считаться только экземпляры класса RailwayStation

  def initialize(name)
    super name
    @@station_list << name
  end

  def self.all
    if @@station_list.empty?
      puts "Список станций пуст"
    else
      puts @@station_list
    end
  end

end
