# coding: utf-8
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'waggon'
require_relative 'passenger_waggon'
require_relative 'cargo_waggon'
require_relative 'station'

# Создаем станции
s1 = Station.new("Msk")
s2 = Station.new("Spb")

# Поезда
pt1 = PassengerTrain.new("P1", "zx3-45")
ct1 = CargoTrain.new("C1", "яч4лп")

pt2 = PassengerTrain.new("P2", "er7-v5")
ct2 = CargoTrain.new("C2", "xcv57")

# Вагоны
pw1 = PassengerWaggon.new('Pw1', 30)
cw1 = CargoWaggon.new('Cw1', 500)
pw1.take_seat
cw1.take_space 100

pw2 = PassengerWaggon.new('Pw2', 50)
cw2 = CargoWaggon.new('Cw2', 700)
5.times { pw2.take_seat }
cw2.take_space 500

# Связь объектов между собой
pt1.add_waggon(pw1)
pt2.add_waggon(pw2)

ct1.add_waggon(cw1)
ct2.add_waggon(cw2)

s1.accept_train(pt1)
s1.accept_train(ct1)

s2.accept_train(pt2)
s2.accept_train(ct2)

Station.all.each do |s|
  puts "На станции #{s.name}:"
  s.train_block do |t|
    puts "Поезд №#{t.number}, тип: #{t.class.type}, число вагонов:#{t.waggonage}"
    puts "В поезде #{t.number}:"
    t.waggon_block do |w|
      if w.is_a? PassengerWaggon
        puts "Вагон #{w.name}, тип: #{w.class.type}, свободные места: #{w.free_seats}, занятые места: #{w.taken_seats}"
      elsif w.is_a? CargoWaggon
        puts "Вагон #{w.name}, тип: #{w.class.type}, свободый объем: #{w.free_space}, занятый объем: #{w.taken_space}"
      end
    end
  end
end
