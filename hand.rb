class Hand
  def initialize
    @cards = []
  end

  def receive(card)
    @cards << card
  end

  def show_hand
    return @cards
  end

  def return
    if @cards.length > 0
      return @cards.pop
    end
  end

end