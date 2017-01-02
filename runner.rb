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

  3.times do
    dealer.receive_card(dealer.deal_card)
  end

  puts dealer.show_hand
  puts dealer.return_card_to_back(dealer.return_card)
  puts dealer.show_hand

  binding.pry

end