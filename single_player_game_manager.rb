require_relative('win_check')

class SinglePlayerGameManager
  def initialize(game_state, all_players, dealer, player1)
    @game_state = game_state
    @dealer = dealer
    @player = player1
    @all_players = all_players
    @win_check = WinCheck.new(self, @game_state, @all_players)
  end

  def play
    initial_deal
    twist_check
  end

  def initial_deal
    @game_state.set_toast_text("Initial deal! All players receive two cards!")
    2.times do
      deal_all
    end
    @game_state.show_hand(@player)
    @game_state.show_hole_card(@dealer)
  end

  def deal_all
    for player in @all_players
      deal(player)
    end
  end

  def deal(player)
    card = @dealer.deal_card
    player.receive_card(card)
    return card
  end

  def twist_check
    if @all_players.length == 2
      @game_state.set_main_text("You're up, " + @player.name + ". Stick or twist?")
      @game_state.get_player_choice
    end
  end

  def turn_handler(choice)
    @game_state.set_main_text("You  " + choice + "!")
    if choice == "twist"
      card = deal(@player)
      @game_state.set_toast_text("You receive the " + card.name + ".")
      @game_state.show_hand(@player)
      @game_state.set_toast_text("#{@player.name} , your hand is now worth #{@win_check.calc_score(@player)}.")
      @win_check.bust_check(@player)
    end

    if choice == "stick"
      @game_state.set_main_text("You stick! Dealer's round!")
      dealers_round
    end
  end

  def dealers_round()
    if @win_check.calc_score(@dealer) <= 16
      @game_state.set_toast_text("Des takes a card!")
      deal(@dealer)
      @win_check.bust_check(@dealer)
      dealers_round
    end
    @game_state.set_toast_text("Des sticks! Show!")
    win_check
  end

  def win_check
    @win_check.show_all_hands
    @win_check.win_check
  end

end