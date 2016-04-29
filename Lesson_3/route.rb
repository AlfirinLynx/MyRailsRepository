# coding: utf-8
class Route

  attr_reader :stations, :first_station, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = []
    @stations << first_station
    @stations << last_station
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
      puts "First and last stations can't be changed!"
    end
  end

	#Если by_name = true, то удаление станции происходит по ее имени, если нет - по экземпляру класса Station
  def delete_station(stat, by_name = false)
    if by_name
      station = station_by_name(stat)
    else
      station = stat
    end
    if stations.first == station || stations.last == station
      puts "First and last stations can't be deleted"
    elsif stations.include?(station) == false
      puts "Station is not on the list!"
    else
      stations.delete(station)
    end
  end

end

