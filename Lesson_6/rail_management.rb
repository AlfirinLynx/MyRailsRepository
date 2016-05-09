# coding: utf-8
class RailManagement
  def initialize
    #Массивы для хранения созданных поездов, станций, вагонов, маршрутов
    @trains = []
    @stations = []
    @waggons = []
    @routes = []
  end

  def create_train_or_wagon_dialogue(obj)
    ar, nm = id_array_name(obj)
    is_train = ( obj == :train) ? true : false
    begin
      puts "\nСоздание нового поезда. Введите необходимые данные\n"
      puts "Это пассажирский #{nm[0...-1]}? Введите 'да' или 'нет'"
      is_pas = nil
      loop do
        is_pas = gets.chomp
        if is_pas == "да" || is_pas == "нет"
          break
        else
          puts "Введите 'да' или 'нет'"
        end
      end
      puts "Введите имя #{nm}"
      name  = gets.chomp
      if is_train
        puts "Введите номер поезда в правильном формате"
        number  = gets.chomp
      end
      
      if is_pas == "да"
        new =  is_train ? PassengerTrain.new(name, number) :  PassengerWaggon.new(name)
        ar << new
        puts "\nСоздан новый пассажирский #{nm[0...-1]} #{new.name}\n"
      elsif is_pas == "нет"
        new =  is_train ? CargoTrain.new(name, number) : CargoWaggon.new(name)
        ar << new
        puts "\nСоздан новый грузовой #{nm[0...-1]} #{new.name}\n"
      end
    rescue => e
      puts e.message
      retry
    end
  end
  

  def create_station
    puts "Введите имя станции"
    name = gets.chomp
    station = Station.new(name)
    stations << station
    puts "Создана новая станция с именем #{station.name}"
  end

  
  def create_route
    puts "Введите имя(номер) маршрута: "
    name = gets.chomp

    msg = "Введите имя первой станции маршрута"
    f_stat = enter_obj_name(:station, msg)
    return if f_stat.nil?

    msg = "Введите имя последней станции маршрута"
    l_stat = enter_obj_name(:station, msg)
    return if l_stat.nil?

    route = Route.new(name, f_stat, l_stat)
    routes << route
    puts "\nСоздан новый маршрут #{route.name}\n"

  end

  def add_wag
    msg = "Введите номер поезда"
    tr = enter_obj_name(:train, msg)
    if tr
      msg =  "Введите имя(номер) вагона"
      wag = enter_obj_name(:waggon, msg)
      tr.add_waggon(wag) if wag
    end
  end

  def del_wag
    msg = "Введите номер поезда"
    tr = enter_obj_name(:train, msg)
    if tr
      msg =  "Введите имя(номер) вагона"
      wag = enter_obj_name(:waggon, msg)
      tr.delete_waggon(wag) if wag
    end
  end

  def train_to_station
    msg = "Введите номер поезда"
    tr = enter_obj_name(:train, msg)
    if tr
      msg = "Введите имя станции"
      st = enter_obj_name(:station, msg)
      st.accept_train(tr) if st
    end
  end

  def trains_at
    msg = "Введите имя станции"
    st = enter_obj_name(:station, msg)
    st.list_trains_by_type if st
  end

  def list_objects(obj)
    ar, name = id_array_name(obj, true)
    if not ar.empty?
      puts "\nСозданные #{name}:\n"
      ar.each { |t| puts t.name}
      puts "\n"
    else
      puts "\nСозданные #{name} отсутствуют\n"
    end
  end

  private
  attr_accessor :trains, :stations, :waggons, :routes

  #Возвращает соответствующий массив по типу(поед, вагон, маршрут, станция), а также имя
  def id_array_name(obj, plur=false)
    ending = plur ? 'ы' : 'а'
    case
    when obj == :train
      obj_ar = trains
      name = "поезда"
    when obj == :waggon
      obj_ar = waggons
       name = "вагон#{ending}"
    when obj == :station
      obj_ar = stations
       name = "станции"
    when obj == :route
      obj_ar = routes
      name = "маршрут#{ending}"
    end
    [obj_ar, name]
  end

  # Вернуть объект по его имени(и "типу")
  def obj_by_name(name, obj)
    ar = id_array_name(obj)[0] #В каком массиве искать
    ar.each { |ob| return ob if ob.name == name}
    nil
  end

  #Часто встречающийся диалог
  def enter_obj_name(obj, msg)
    res = nil
    loop do
      puts msg + "(или для возврата введите q): "
      inp  = gets.chomp
      return res if inp == 'q'
      res  = obj_by_name(inp, obj)
      if res
        break
      else
        puts "Объекта  с таким именем не существует"
      end
    end
      res

  end
    
  

end
