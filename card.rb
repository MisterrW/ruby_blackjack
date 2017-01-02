class Card
  attr_accessor :suit, :value
  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def name
    return "#{@value} of #{@suit}"
  end
end