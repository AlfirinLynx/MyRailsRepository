F = [0, 1]

while true
	s =  F[-1] + F[-2]
	if s < 100
		F << s
	else
		break
	end
end

puts F
