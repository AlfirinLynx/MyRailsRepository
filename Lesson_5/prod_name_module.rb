module ProdName
  def set_producer_name(name)
    self.prod_name = name
  end

  def show_producer_name
    prod_name
  end

  protected
  attr_accessor :prod_name
end
