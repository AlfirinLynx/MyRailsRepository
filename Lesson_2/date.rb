puts "Введите число (день месяца)"

day = gets.chomp.to_i

puts "Введите номер месяца"

month = gets.chomp.to_i

puts "Введите год"

year = gets.chomp.to_i

IsLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)

days_months = {1 => 31, 2 => IsLeapYear ? 29 : 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 =>30, 10 => 31, 11 => 30, 12 => 31}

s = 0

days_months.select { |key| key < month}.each { |key, val| s += val}

s += day

puts "Порядковый номер даты с начала года: #{s}" + (s == 256 ? " (День программиста!!!)" : "")

