# coding: utf-8
require_relative 'type_setter'
require_relative 'waggon'
class PassengerWaggon < Waggon
  include TypeSetter

  attr_reader :taken_seats, :seats

  def initialize(name, seats)
    @seats = seats
    @taken_seats = 0
    super name
  end

  def free_seats
    seats - taken_seats
  end

  def take_seat
    self.taken_seats += 1 if free_seats > 0
  end

  protected

  attr_writer :taken_seats, :seats
  def validate!
    super
    raise 'seats must be an integer number' unless seats.is_a? Fixnum
  end
end
