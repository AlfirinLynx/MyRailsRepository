f = [0, 1]
s = 1

while s < 100
  f << s
  s =  f[-1] + f[-2]
end

puts f
