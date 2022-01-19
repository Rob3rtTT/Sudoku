require_relative 'grid.rb'
class Game
    

    def initialize(board=Board.empty_grid)
        @board=board
    end

    def play
        until @board.solved?
            system("clear")
            @board.render
            update_tile(prompt,prompt_value)
        end
        p "Congratulations, you have won!"
    end

    def prompt
        p "Please enter the coordinates of the tile you'd like to modify. Please enter 2 values, like: 1,2."
        vals=gets.chomp.split(',').map(&:to_i)
        until good_vals?(vals)
            vals=prompt
        end
        return vals
    end

    def good_vals?(vals)
        if vals.length != 2 || vals.any?{|val| val > @board.size-1}
            p "Please enter 2 values separated by commas!"
            return false
        end
        if @board[vals].given?
            p "Value already give, please chose another one!"
            return false
        end
        true
    end

    def prompt_value
        p "Please enter a value from 1-9"
        val=gets.chomp
        until check_value(val)
            val=prompt_value
        end
        return val.to_i
    end

    def check_value(val)
        if !(1..9).to_a.include?(val.to_i)
            p "Please input a NUMBER that is between 1 and 9!"
            return false
        end
        true
    end

    def update_tile(prompt,value)
        @board[prompt]=value
    end

    private
    attr_reader :board 
end

game=Game.new(Board.from_file('./puzzles/sudoku1solved.txt'))
game.play