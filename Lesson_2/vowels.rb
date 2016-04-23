vowels = ['а', 'е', 'ё', 'и', 'о', 'у', 'ы', 'э', 'ю', 'я']

vow_hash = Hash.new

i = 1

('а'..'я').each do |l| 
	vow_hash[l] = i if vowels.include? l
	i += 1
end

puts vow_hash

