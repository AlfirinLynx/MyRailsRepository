class Station

  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    trains << train
    puts "A train has arrived at the station"
  end

  def list_trains
    if trains.any?
      puts "Currently at the station there are trains with numbers:"
      trains.each {|t| puts t.number}
    else
      puts "No trains at the station currently"
    end
  end

  def list_trains_by_type
    if trains.any?
      pt = 0
      lt = 0
      trains.each do |t| 
	lt += 1 if t.type == "cargo"
	pt += 1 if t.type == "passenger"
      end
      puts "Currently at the station there are #{lt} cargo and #{pt} passenger trains"
      
    else
      puts "No trains at the station currently"
    end
  end

  def send_train(train)
    if trains.include? train
      trains.delete(train)
    else
      puts "No such train currently at the station"
    end
  end



end
