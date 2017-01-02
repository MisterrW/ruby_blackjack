module Player
  attr_reader :name, :score, :special_score, :winner
  attr_writer :score, :special_score, :winner

  def player_initialize(args)
    @hand = args[:hand]
    @name = args[:name]
    @score = 0
    @special_score = ""
    @winner = false
  end

  def show_hand
    return @hand.show_hand
  end

  def receive_card(card)
    @hand.receive(card)
  end

  def return_card
    return @hand.return
  end

end