class Train
	attr_accessor :speed
	attr_reader :num_of_waggons, :route, :cur_station, :number, :type

	def initialize(number, type = 'passenger', num_of_waggons = 15)
		@number = number
		@type = type  #'cargo' - грузовой, 'passenger' - пассажирский
		@num_of_waggons = num_of_waggons
		@speed = 0
	end

	def go
		self.speed = 70
	end

	def show_speed
		speed
	end

	def stop
		self.speed = 0
	end

	def waggonage
		puts "The train consists of #{num_of_waggons} waggons"
	end

	def add_waggon
		if speed == 0
			@num_of_waggons +=1
		else
			puts "Stop the train prior to adding a waggon!"
		end
	end

	def delete_waggon
		if speed == 0
			@num_of_waggons -=1 if num_of_waggons > 0 
		else
			puts "Stop the train prior to deleting a waggon!"
		end
	end

	def accept_route(route)
		@route = route
		@cur_station = route.first_station
	end

	def go_to_station(stat, by_name = false)
		if route
			if by_name
				station = route.station_by_name(stat)
			else
				station = stat
			end
			if route.stations.include? station
				@cur_station = station
			else
				puts "Station is not in the current route"
			end
		else
			puts "No route defined for this train"
		end
	end

	def show_current_station
		if cur_station
			puts "Current station's name is #{cur_station.name}"
		else
			puts "Has not visited stations yet"
		end
	end

	def show_next_station
		if route
			st = route.next_to(cur_station)
			if st
				puts "Next station's name is #{st.name}"
			else
				puts "This is the last station"
			end
		else
			puts "No route defined for this train"
		end
	end

	def show_prev_station
		if route
			st = route.prev_to(cur_station)
			if st
				puts "Previous station's name is #{st.name}"
			else
				puts "This is the first station"
			end
		else
			puts "No route defined for this train"
		end
	end



end