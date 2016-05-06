require_relative 'prod_name_module'

class Waggon
  include ProdName
  attr_reader :name
  def initialize(name)
    @name = name
  end
end
