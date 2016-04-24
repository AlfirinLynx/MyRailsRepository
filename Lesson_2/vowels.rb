vowels = ['а', 'е', 'ё', 'и', 'о', 'у', 'ы', 'э', 'ю', 'я']

vow_hash = {}


('а'..'я').each_with_index { |l, i| vow_hash[l] = i+1 if vowels.include? l }

puts vow_hash

