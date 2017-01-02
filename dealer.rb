class Dealer
  include Player
  def initialize(args)
    @deck = args[:deck]
    player_initialize(args)
  end

  def fill_deck
    @deck.fill_deck
  end

  def shuffle_cards
    @deck.shuffle_cards
  end

  def deal_card
    return @deck.deal_card
  end

  def return_card_to_back(card)
    @deck.return_card_to_back(card)
  end
end