class WinCheck

  def initialize(game_manager, game_state, all_players)
    @game_state = game_state
    @all_players = all_players
    @outcome = ""
    @single_player_game_manager = game_manager
    @player = all_players[0]
    @dealer = all_players[1]
  end

  def show_all_hands
    for player in @all_players
      show_hand(player)
    end
  end

  def show_hand(player)
    @game_state.show_any_hand(player)
  end

  def calc_score(player)
    score = 0
    value_scorer = {
      two: 2,
      three: 3,
      four: 4,
      five: 5,
      six: 6,
      seven: 7,
      eight: 8,
      nine: 9,
      ten: 10,
      jack: 10,
      queen: 10,
      king: 10,
      ace: 11
    }

    for card in player.show_hand
      score += value_scorer[card.value]
    end

    player.score = score

    for card in player.show_hand
      if card.value == :ace
        if player.score > 21
          @game_state.set_toast_text("Aces low!")
          player.score -= 10
        end
      end
    end

    if player.score == 21 && player.show_hand.length == 2
      game_state.set_toast_text("#{player.name} has a Pontoon! #{player.show_hand[0].name}  and  #{player.show_hand[1].name}.")
      player.special_score = "pontoon"
    elsif player.score <= 21 && player.show_hand.length >= 5
      game_state.set_toast_text("#{player.name} has a 5 card trick!")
      player.special_score = "5 card trick"
    end

    return player.score
  end

  def bust_check(player)
    if calc_score(player) > 21
      show_hand(player)
      player.special_score = "bust"
      @all_players.delete(player)
      binding.pry
     win_check
    end
  end

  # def fakeBustCheck(player)
  #     if calc_score(player) > 21
  #         show_hand(player)
  #         player.special_score = "bust"
  #         @all_players.remove(player)
  #         fakeWinCheck
  #     end
  # end

  def win_check
    for player in @all_players
      calc_score(player)
    end
   win_check_special_score
    @game_state.set_main_text(@outcome)
    end_game
  end

  # public String fakeWinCheck {
  #     for ( player : all_(layers)
  #         calcScore(player)
  #     end

  #    winCheckSpecialScore
  #     return @outcome
  #     //        @game_state.set_main_text(@outcome)
  #     //        endGame
  # end

  def end_game
    @game_state.end_game(@player, @dealer)
  end

  def win_check_special_score
    if @all_players.length == 2
      if @all_players[0].special_score == "pontoon" && !@all_players[1].special_score == "pontoon"
        @outcome = "#{@all_players[0].name} wins with pontoon!"
        @all_players[0].winner = true
        return
      elsif @all_players[1].special_score == "pontoon" && !@all_players[0].special_score == "pontoon"
        @outcome = "#{@all_players[1].name} wins with pontoon!"
        @all_players[1].winner = true
        return
      elsif @all_players[0].special_score == "pontoon" && @all_players[1].special_score == "pontoon"
        @outcome = "Wow, two pontoons! Draw!"
        return
      elsif @all_players[0].special_score == "5 card trick" && !@all_players[1].special_score == "5 card trick"
        @outcome = "#{@all_players[0].name} wins with 5 card trick!"
        @all_players[0].winner = true
        return
      elsif @all_players[1].special_score == "5 card trick" && !@all_players[0].special_score == "5 card trick"
        @outcome = "#{@all_players[1].name} wins with 5 card trick!"
        @all_players[1].winner = true
        return
      elsif @all_players[0].special_score == "5 card trick" && @all_players[1].special_score == "5 card trick"
        @outcome = "Wow, two 5 card tricks! Draw!"
        return
      else
       win_check_normal_score
      end
     win_check_normal_score
    end
  end

  def win_check_normal_score
    if @all_players.length == 2
      if @all_players[0].score > @all_players[1].score
        @outcome = "#{@all_players[0].name} wins with #{@all_players[0].score}!"
        @all_players[0].winner = true
        return
      elsif @all_players[0].score < @all_players[1].score
        @outcome = "#{@all_players[1].name} wins with #{@all_players[1].score}!"
        @all_players[1].winner = true
        return
      else
        @outcome = "It's a draw!"
        return
      end
    elsif @all_players.length == 1
      binding.pry
      @outcome = "#{@all_players[0].name} wins with #{@all_players[0].score}!"
      @all_players[0].winner = true
      return
    elsif @all_players.length == 0
      @outcome = "Everyone's bust! Draw!"
      return
    end
  end

end