puts "Введите число (день месяца)"

day = gets.chomp.to_i

puts "Введите номер месяца"

month = gets.chomp.to_i

puts "Введите год"

year = gets.chomp.to_i

is_leap_year = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)

days_months = [31, is_leap_year ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

s = day

days_months[0...(month-1)].each { |key| s += key}


puts "Порядковый номер даты с начала года: #{s}" + (s == 256 ? " (День программиста!!!)" : "")

