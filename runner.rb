require_relative('deck')
require_relative('player')
require_relative('gambler')
require_relative('dealer')
require_relative('hand')
require('pry-byebug')

class Runner

  # deck = Deck.new()
  # deck.fill_deck

  dealer = Dealer.new({
    name: "Fred",
    hand: Hand.new(),
    deck: Deck.new()
    })
  dealer.fill_deck
  dealer.shuffle_cards
  binding.pry

end