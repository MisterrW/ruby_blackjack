require_relative('card')
class Deck

  def initialize
    @cards = []
  end

  def fill_deck
    suits = [:hearts, :diamonds, :spades, :clubs]
    values = [:two, :three, :four, :five, :six, :seven, :eight, :nine, :ten, :jack, :queen, :king, :ace]
    suits.each do |suit|
      values.each do |value|
        @cards << Card.new(suit, value)
      end
    end
  end

  def shuffle_cards
    @cards.shuffle!
  end

  def get_card(n)
    return @cards[n]
  end

  def deal_card
    return @cards.pop
  end

  def get_deck
     return @cards
  end

  def return_card_to_back(card)
    @cards.unshift(card)
  end

end