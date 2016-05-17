# coding: utf-8
require_relative 'validation'
class Station
  include Validation
  attr_reader :name
  validate :name, :presence

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
  end

  def train_block
    return 'No block' unless block_given?
    trains.each { |t| yield t }
  end

   def accept_train(train)
    trains << train
  end

  def list_trains
    if trains.any?
      puts "В данный момент на станции поезда с номерами:"
      trains.each { |t| puts t.name }
    else
      puts "На станции нет поездов в данный момент"
    end
  end

  def list_trains_by_type
    return "Нет поездов на станции в данный момент" if trains.empty?
    pt = 0
    lt = 0
    trains.each do |t|
      lt += 1 if t.is_a? CargoTrain
      pt += 1 if t.is_a? PassengerTrain
    end
    puts "В данный момент на станции #{lt} грузовых и  #{pt} пассажирских поездов"
  end

  def send_train(train)
    trains.delete(train)
  end

  protected

  attr_accessor :trains

end
