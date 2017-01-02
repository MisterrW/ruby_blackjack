require_relative("hand")
require_relative("deck")
require_relative("dealer")
require_relative("gambler")
require_relative("single_player_game_manager")

class GameState 
    def initialize
        @main_text = "Welcome to Pontoon"
        print_text(@main_text)
    end

    def singleplayer_continue(gambler, dealer)
        @all_players = [gambler, dealer]
        @game = SinglePlayerGameManager.new(self, @all_players, dealer, gambler)
        @game.play
    end

    def singleplayer_setup
        dealer = Dealer.new({
            name: "Des the Dealer",
            hand: Hand.new,
            deck: Deck.new
            })
        gambler = Gambler.new({
            name: "Jeff",
            hand: Hand.new
            })
        @all_players = [gambler, dealer]
        @game = SinglePlayerGameManager.new(self, @all_players, dealer, gambler)
        @game.play()
    end

    def set_main_text(text)
        @main_text = text
        print_text(@main_text)
    end

    def get_main_text
        return @main_text
    end

    def set_toast_text(text)
        @toast_text = text
    end

    def set_player_name(player_name)
        @player_name = player_name
    end

    def show_hand(player)
        print_text(show_any_hand(player))
        # getPlayerChoice()
    end

    def show_hole_card(dealer)
        card = dealer.show_hand[0]
        print_text("Dealer's hole card:")
        print_text(" - #{card.name}")
    end

    def show_dealer_hand(dealer) 
        dealer_hand = show_any_hand(dealer)
        update_dealer_hand(dealer_hand)
        print_text(dealer_hand)
    end

    def show_any_hand(player)
        hand = "#{player.name}:"
        cards = player.show_hand
        for card in cards 
            temp = "\n - #{card.name}"
            hand = "#{hand} #{temp}"
        end
        return hand
    end

    def get_player_choice
        print_text("Type stick or twist.")
        choice = gets.chomp.downcase
        set_player_choice(choice)
    end

    def set_player_choice(choice)
        @game.turn_handler(choice)
        get_player_choice
    end

    def print_text(text) 
        puts text
    end

    def update_dealer_hand(text) 
        # setup.setDealerHand(text)
    end

    def end_game(player, dealer)
        players = [player, dealer]
        show_hand(player)
        show_dealer_hand(dealer)
        # binding.pry
        # players.each do |endplayer|
        #     if endplayer.winner
        #         print_text("#{endplayer.name} wins!")
        #     else
        #         print_text("#{endplayer.name} loses!")
        #     end
        # end
        print_text("Game over!")
        print_text("Play again? y / n")
        choice = gets.chomp.downcase
        if choice == "y"
            Runner.setup
        else
            exit
        end
    end
end