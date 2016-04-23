bucket = Hash.new


loop do
	puts "Введите название товара (для выхода введите 'стоп'): "
	prod = gets.chomp
	break if prod == 'стоп'

	puts "Введите цену за единицу товара: "
	price = gets.chomp.to_f

	puts "Введите количество купленного товара: "
	num = gets.chomp.to_f

	bucket[prod] = { Цена: price, Количество: num}
end 


puts "\nСодержимое Вашей корзины: "
puts bucket

s = 0
puts "\nИтоговые суммы по товарам: "
bucket.each do |k, v| 
	r = v[:Цена]*v[:Количество]
	puts "#{k}: #{r}"
	s += r
end



puts "\nСумма всех покупок: #{s}"