# coding: utf-8
require_relative 'instance_counter'
require_relative 'station'
class RailwayStation < Station
  include InstanceCounter
  @@station_list = [] #Будут считаться только экземпляры класса RailwayStation

  def initialize(name)
    super name
    @@station_list << name
    register_instance
  end

  def self.all
    if @@station_list.empty?
      puts "Список станций пуст"
    else
      puts @@station_list
    end
  end

end
