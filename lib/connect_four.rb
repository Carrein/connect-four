=begin
"▦" "◍"
=end

class ConnectFour

    attr_accessor :won, :board

    def initialize
        @board = Array.new(6) {Array.new(7, " ⚬ ")}
        @round = 1
        @player = 1
        @won = false
        @prompt = ">"
        @max = {
            "0" => 0,
            "1" => 0,
            "2" => 0,
            "3" => 0,
            "4" => 0,
            "5" => 0,
            "6" => 0,
        }
    end

    public

    def game_manager
        while !@won
            render
            @won = insert(input)
            wincon
        end
        render
        puts "Player #{@player} won the game!"
    end

    def render
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

    def input
        @round%2 == 1 ? @player = 1 : @player = 2      
        puts "Player #{@player} turn! Enter a number from 0..6."
        print "#{@prompt} "
        answer = gets.chomp
        while !(error(answer))
            puts "Invalid input. Only numerical values from 0..6 are accepted."
            print "#{@prompt} "
            answer = gets.chomp
        end
        while @max[answer] >= 6
            puts "Invalid input. Selected column is full! Please reenter"
            print "#{@prompt} "
            answer = gets.chomp
        end
        @round += 1
        return answer
    end

    def error(tmp)
        if tmp.match(/^[0-6]$/) #test is answer is between 0-6
            return true
        end
        return false
    end

    def insert(ans)
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
        @board.each do |i|
            horizontal = []
            i.each do |j|
                horizontal << j.strip
            end
            return true if (horizontal.join =~ /\u25CD{4}/) || (horizontal.join =~ /\u25A6{4}/) #Checks horizontal.
        end
        7.times do |i|
            vertical = []
            6.times do |j|
                vertical << @board[j][i].strip
            end
            return true if (vertical.join =~ /\u25CD{4}/) || (vertical.join =~ /\u25A6{4}/) #Checks vertical.
        end
        7.times do |j|
            ltop_diagonal = []
            lbtm_diagonal = []
            rtop_diagonal = []
            rbtm_diagonal = []
            6.times do |i|
                #puts "max: #{i+j},#{6-i}" if i+j < 6
                #puts "min: #{i}, #{6-i-j}" if i+j < 7
                ltop_diagonal << @board[i+j][i].strip if i+j < 6
                lbtm_diagonal << @board[i][i+j].strip if i+j < 7
                rtop_diagonal << @board[i][6-i-j].strip if i+j < 7
                rbtm_diagonal << @board[i+j][6-i].strip if i+j < 6
            end
            puts ""
            return true if (ltop_diagonal.join =~ /\u25CD{4}/) || (ltop_diagonal.join =~ /\u25A6{4}/) #Checks left to right top diagonal.
            return true if (lbtm_diagonal.join =~ /\u25CD{4}/) || (lbtm_diagonal.join =~ /\u25A6{4}/) #Checks left to right btm diagonal.
            return true if (rtop_diagonal.join =~ /\u25CD{4}/) || (rtop_diagonal.join =~ /\u25A6{4}/) #Checks right to left top diagonal.
            return true if (rbtm_diagonal.join =~ /\u25CD{4}/) || (rbtm_diagonal.join =~ /\u25A6{4}/) #Checks right to left btm diagonal.
        end
    end
end

=begin
new_game = ConnectFour.new
puts "Welcome to Connect Four!"
new_game.game_manager
=end