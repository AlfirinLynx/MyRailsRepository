# coding: utf-8
class RailManagement
  
  def initialize
    # Для хранения созданных поездов, станций, вагонов, маршрутов
    @trains = {}
    @stations = {}
    @waggons = {}
    @routes = {}
  end

  def create_train_or_wagon_dialogue(obj)
    ar, nm = id_array_name(obj)
    is_train = (obj == :train) ? true : false
    begin
      puts "\nСоздание нового #{nm}. Введите необходимые данные\n"
      is_pas = yes_no_dial("Это пассажирский #{nm[0...-1]}? Введите 'да' или 'нет'")
      name = enter("Введите имя #{nm}")
      number = enter("Введите номер поезда в правильном формате") if is_train
           
      if is_pas == "да"
        new = is_train ? PassengerTrain.new(name, number) : PassengerWaggon.new(name, enter("Введите общее количество пассажирских мест").to_i)
        puts "\nСоздан новый пассажирский #{nm[0...-1]} #{new.name}\n"
      else
        new = is_train ? CargoTrain.new(name, number) : CargoWaggon.new(name, enter("Введите общий объем грузового вагона").to_f)
        puts "\nСоздан новый грузовой #{nm[0...-1]} #{new.name}\n"
      end
      ar[name] = new
    rescue => e
      puts e.message
      retry
    end
  end
  

  def create_station
    name = enter("Введите имя станции")
    station = Station.new(name)
    stations[name] = station
    puts "Создана новая станция с именем #{station.name}"
  end

  
  def create_route
    name = enter("Введите имя(номер) маршрута: ")
    f_stat = enter_obj_name(:station, "Введите имя первой станции маршрута")
    return if f_stat.nil?
    l_stat = enter_obj_name(:station, "Введите имя последней станции маршрута")
    return if l_stat.nil?
    route = Route.new(name, f_stat, l_stat)
    routes[name] = route
    puts "\nСоздан новый маршрут #{route.name}\n"
  end

  def list_wag
    tr = enter_obj_name(:train, "Введите имя поезда")
    return unless tr
    puts "В поезде #{tr.name}:"
    tr.waggon_block do |w|
      if w.is_a? PassengerWaggon
        puts "Вагон #{w.name}, тип: #{w.class.type}, свободные места: #{w.free_seats}, занятые места: #{w.taken_seats}"
      elsif w.is_a? CargoWaggon
        puts "Вагон #{w.name}, тип: #{w.class.type}, свободый объем: #{w.free_space}, занятый объем: #{w.taken_space}"
      end
    end
  end

  def take_space_or_seat
    wag = enter_obj_name(:waggon, "Введите имя(номер) вагона")
    return unless wag
    if wag.is_a? PassengerWaggon
      wag.take_seat
      puts "Место занято. Число свободных мест: #{wag.free_seats}"
    else
      wag.take_space(enter("Введите объем, который требуется занять").to_f)
      puts "Объем занят. Свободный объем: #{wag.free_space}"
    end
  end
  
  def add_wag
    tr = enter_obj_name(:train, "Введите имя поезда")
    return unless tr
    wag = enter_obj_name(:waggon, "Введите имя(номер) вагона")
    tr.add_waggon(wag) if wag
  end

  def del_wag
    tr = enter_obj_name(:train, "Введите имя поезда")
    return unless tr
    wag = enter_obj_name(:waggon, "Введите имя(номер) вагона")
    tr.delete_waggon(wag) if wag
  end

  def trains_at
    st = enter_obj_name(:station, "Введите имя станции")
    return unless st
    puts "На станции #{st.name}:"
    st.train_block { |t| puts "Поезд №#{t.number}, тип: #{t.class.type}, число вагонов:#{t.waggonage}" }
  end

  def train_to_station
    tr = enter_obj_name(:train, "Введите имя поезда")
    return unless tr
    st = enter_obj_name(:station, "Введите имя станции")
    st.accept_train(tr) if st
  end

  def list_objects(obj)
    ar, name = id_array_name(obj, true)
    if ar.any?
      puts "\nСозданные #{name}:\n"
      ar.each { |k, v| puts k }
      puts "\n"
    else
      puts "\nСозданные #{name} отсутствуют\n"
    end
  end

  private
  
  attr_accessor :trains, :stations, :waggons, :routes

  # Возвращает соответствующий массив по типу(поед, вагон, маршрут, станция), а также имя
  def id_array_name(obj, plur = false)
    ending = plur ? 'ы' : 'а'
    hashes = { train: [@trains, "поезда"], station: [@stations, "станции"], waggon: [@waggons, "вагон#{ending}"], route: [@routes, "маршрут#{ending}"] }
    hashes[obj]
  end

  # Вернуть объект по его имени(и "типу")
  def obj_by_name(name, obj)
    ar = id_array_name(obj)[0] # В каком хэше искать
    ar[name]
  end

  # Часто встречающиеся диалоги
  
  def enter(msg)
    puts msg
    gets.chomp
  end
  
  def enter_obj_name(obj, msg)
    res = nil
    loop do
      inp = enter(msg + "(или для возврата введите q): ")
      return res if inp == 'q'
      res = obj_by_name(inp, obj)
      break if res
      puts "Объекта  с таким именем не существует"
    end
    res
  end

  def yes_no_dial(msg)
    puts msg
    yn_var = nil
    loop do
      yn_var = gets.chomp
      break if yn_var == "да" || yn_var == "нет"
      puts "Введите 'да' или 'нет'"
    end
    yn_var
  end
end
