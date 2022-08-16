require "pry"
class TicTacToe
    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]
    attr_accessor :board
    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end
    def input_to_index(input)
        input.to_i - 1
    end
    def move(index, xo = "x")
        self.board[index] = "#{xo}"
    end
    def position_taken?(index)
        if self.board[index] == " "
            false
        elsif self.board[index] == "X" || "O"
            true
        end
    end
    def valid_move?(position)
        #binding.pry
        if position_taken?(position) == false
            if position <= 8 && position >= 0
                true
            end
        else
            false
        end
    end
    def turn_count
        9 - board.count(" ")
    end
    def current_player
        turn_count%2 === 0 ? "X" : "O"
    end
    def turn
        puts "make your move pick a position 1-9"
        user_input = gets.chomp
        user_index = input_to_index(user_input)
        if valid_move?(user_index) 
            move(user_index, current_player)
            display_board 
        else
            turn
        end
    end
    def won?
        winning_combo = nil
        WIN_COMBINATIONS.each do|combo|
            winner = (board[combo[0]] != " ") &&
            (board[combo[0]] == board[combo[1]]) && 
            (board[combo[1]] == board[combo[2]])
            if winner
                winning_combo = combo
                break
            end
        end
        winning_combo
    end
    def full?
        board.all? {|space| space != " "}
    end
    def draw?
        full? && won? == nil 
    end
    def over?
        won? || draw?
    end
    def winner
        #binding.pry
        if won? == nil
            nil
        else 
            board[won?[0]]
        end
    end
    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end
    def play
        turn until over? 
        #binding.pry
        if winner == nil
            puts 'Cat\'s Game!'
        elsif winner != nil
             puts "Congratulations #{winner}!"
        end
    end
end