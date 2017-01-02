require_relative('deck')
require_relative('player')
require_relative('gambler')
require_relative('dealer')
require_relative('hand')
require_relative('gamestate')
require('pry-byebug')

class Runner

  # deck = Deck.new()
  # deck.fill_deck
  def self.setup

    dealer = Dealer.new({
      name: "Dealer",
      hand: Hand.new,
      deck: Deck.new
      })

    gambler = Gambler.new({
      name: "Gambler",
      hand: Hand.new,
      })

    dealer.fill_deck
    dealer.shuffle_cards

    game_state = GameState.new
    game_state.singleplayer_continue(gambler, dealer)

  end

  self.setup

  # 3.times do
  #   dealer.receive_card(dealer.deal_card)
  # end

  # puts dealer.show_hand
  # puts dealer.return_card_to_back(dealer.return_card)
  # puts dealer.show_hand

  # binding.pry

end