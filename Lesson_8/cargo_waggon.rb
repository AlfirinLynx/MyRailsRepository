# coding: utf-8
require_relative 'type_setter'
require_relative 'waggon'
class CargoWaggon < Waggon
  include TypeSetter
  
  attr_reader :space, :taken_space
  
  def initialize(name, space)
    super name
    @space = space
    @taken_space = 0
  end

  def free_space
    space - taken_space
  end

  def take_space(amount)
    self.taken_space += amount if free_space >= amount
  end

  
  private
  
  attr_writer :space, :taken_space
end
