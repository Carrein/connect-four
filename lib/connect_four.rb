class ConnectFour
    attr_accessor :won, :board, :draw #accessed by spec file for testing conditions.

    def initialize
        @board = Array.new(6) {Array.new(7, " ⚬ ")} #Empty 2d array to simulate playing field.
        @round = 1 #Keeps track of current round.
        @player = 1 #Keeps track of current round and player.
        @won = false #Checks if win condition has been met.
        @draw = false #Checks if draw condition is met.
        @max = { #Hash to keep track of maximum pieces in each column.
            "0" => 0,
            "1" => 0,
            "2" => 0,
            "3" => 0,
            "4" => 0,
            "5" => 0,
            "6" => 0,
        }
    end

    def game_manager
        puts "Welcome to Connect Four!"
        while !@won || !@draw
            render
            insert(input)
            @won = wincon
        end
        render
        puts @draw == false ? "Player #{@player} won the game!" : "It's a draw"
    end

    def render #Prints out the board.
        @board.each do |i|
            puts "\n"
            i.each do |j|
                print j
            end
        end
        puts "\n"
        puts "---------------------"
        puts " 0  1  2  3  4  5  6"
        puts "\n"
    end

    def input #Gets input from current player.
        @round%2 == 1 ? @player = 1 : @player = 2
        puts "Player #{@player} turn! Enter a number from 0..6."
        answer = gets.chomp
        while !(error(answer)) || @max[answer] == 6
            puts "Invalid input. Either column is full, or digit is wrong. Please try again."
            answer = gets.chomp
        end
        @round += 1
        return answer
    end

    def error(tmp) #Error checking, only accepts digits between 0-6
        return true if tmp.match(/^[0-6]$/)
        return false
    end

    def insert(ans) #Takes input parameter and fills @board and @max.
        tmp = ans.to_i
        @board.reverse.each do |i|
            if i[tmp] == " ⚬ "
                if @player == 1
                    i[tmp] = " ▦ "
                    @max[tmp.to_s] += 1
                    break
                else
                    i[tmp] = " ◍ "
                    @max[tmp.to_s] +=1
                    break
                end
            end
        end
    end

    def wincon
        draw = []
        7.times do |j|
            draw << @board[0][j].strip
            if !(draw.join =~ /\u26AC/)
                @draw = true
            end
            ltop_diagonal = []
            lbtm_diagonal = []
            rtop_diagonal = []
            rbtm_diagonal = []
            vertical = []
            horizontal = []
            6.times do |i|
                ltop_diagonal << @board[i+j][i].strip if i+j < 6
                lbtm_diagonal << @board[i][i+j].strip if i+j < 7
                rtop_diagonal << @board[i][6-i-j].strip if i+j < 7
                rbtm_diagonal << @board[i+j][6-i].strip if i+j < 6                
                vertical << @board[i][j].strip
                horizontal << @board[j][i].strip if j < 6
            end
            return true if (ltop_diagonal.join =~ /\u25CD{4}/) || (ltop_diagonal.join =~ /\u25A6{4}/) #Checks left to right top diagonal.
            return true if (lbtm_diagonal.join =~ /\u25CD{4}/) || (lbtm_diagonal.join =~ /\u25A6{4}/) #Checks left to right btm diagonal.
            return true if (rtop_diagonal.join =~ /\u25CD{4}/) || (rtop_diagonal.join =~ /\u25A6{4}/) #Checks right to left top diagonal.
            return true if (rbtm_diagonal.join =~ /\u25CD{4}/) || (rbtm_diagonal.join =~ /\u25A6{4}/) #Checks right to left btm diagonal.
            return true if (vertical.join =~ /\u25CD{4}/) || (vertical.join =~ /\u25A6{4}/) #Checks vertical.
            return true if (horizontal.join =~ /\u25CD{4}/) || (horizontal.join =~ /\u25A6{4}/) #Checks horizontal.
        end
        return false
    end
end


#new_game = ConnectFour.new
#new_game.game_manager
