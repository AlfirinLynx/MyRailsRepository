# coding: utf-8
require_relative 'prod_name_module'

class Waggon
  include ProdName

  attr_reader :name

  def initialize(name)
    @name = name
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise "Имя вагона должно быть непустым" if name.empty?
    true
  end
end
