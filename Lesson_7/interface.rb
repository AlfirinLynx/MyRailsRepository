# coding: utf-8
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'waggon'
require_relative 'cargo_waggon'
require_relative 'passenger_waggon'
require_relative 'rail_management'

management = RailManagement.new

loop do
  puts "Введите команду, введите 'cm' для получения всего списка команд, введите 'q' для выхода"
com_list = "
train - создать поезд
waggon - создать вагон
station - создать станцию
route - создать маршрут
add_wag - добавить вагон к поезду
del_wag - отцепить вагон
wag_take - занять место или объем в вагоне(в зависимости от типа)
list_wag - просмотреть список вагонов поезда
train_to_st - поместить поезд на станцию
list_st - просмотреть существующие станции
trains_at - просмотреть список поездов на станции
q - выход
"
  com = gets.chomp
  break if com == 'q'

  case
  when com == 'cm'
    puts com_list
  when com == 'train'
    management.create_train_or_wagon_dialogue(:train)
    management.list_objects(:train)
  when com == 'waggon'
    management.create_train_or_wagon_dialogue(:waggon)
    management.list_objects(:waggon)
  when com == 'route'
    management.create_route
    management.list_objects(:route)
  when com == 'station'
    management.create_station
    management.list_objects(:station)
  when com == 'add_wag'
    management.add_wag
  when com == 'del_wag'
    management.del_wag
  when com == 'train_to_st'
    management.train_to_station
  when com == 'list_st'
    management.list_objects(:station)
  when com == 'trains_at'
    management.trains_at
  when com == 'list_wag'
    management.list_wag
  when com == 'wag_take'
    management.take_space_or_seat
  else
    puts "Неизвестная команда"
  end
      
end
