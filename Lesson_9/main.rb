# coding: utf-8
require_relative 'train'
require_relative 'station'
require_relative 'route'


# У класса поезд валидаторы:
# validate :name, :presence
# validate :number, :format, NUMBER_FORMAT

t = Train.new('A', '1q3-5f') # Здесь - все верно
puts t.valid? # Вернет true

t1 = Train.new('', '12345') # Валидация не прошла - пустое имя

t2 = Train.new('D', '12n-89756') # Ошибка - неверный формат номера



# У класса Station
# validate :name, :presence

s1 = Station.new('M')
puts s1.valid? # True
s2 = Station.new('S')
puts s2.valid? # True

s3 = Station.new('') # пустое имя - валидация не прошла



# У класса Route
# validate :name, :presence
# validate :first_station, :type, Station
# validate :last_station, :type, Station

r1 = Route.new('R', s1, s2) # Все верно
puts r1.valid? # True

r2 = Route.new('', s1, s2) # Ошибка - пустое имя

r3 = Route.new('M', 'cat', s2) # Ошибка - вместо объекта класса Station передана строка

r4 = Route.new('A', s1, 15) # Ошибка - вместо объекта класса Station передано число
