require_relative 'tile.rb'
class Board
    attr_reader :grid
    def self.empty_grid
        Array.new(9){Array.new(9){Tile.new(0)}}
    end

    def self.from_file(filename)
        rows=File.readlines(filename).map(&:chomp)
        tiles=rows.map do |row|
            nums=row.split("").map{|char| Integer(char)}
            nums.map{|num|Tile.new(num)}
        end
        self.new(tiles)
    end


    def initialize(grid = Board.empty_grid)
        @grid=grid
    end

    def [](pos)
        row,col=pos
        @grid[row][col]
    end

    def []=(pos,val)
        row,col=pos
        tile=@grid[row][col]
        tile.value=val
    end

    def render
        system("clear")
        puts "    #{(0...@grid.length).to_a.join(" ")}"
        puts "----------------------"
        @grid.each_with_index do |row,i|
            puts "#{i} | #{row.join(" ")}"
        end
    end
    
    def rows
        @grid
    end

    def columns
        rows.transpose
    end

    def solved?
        rows.all?{|row| solved_set?(row)}&&
        columns.all?{|col| solved_set?(col)}&&
        squares.all?{|square| solved_set?(square)}
    end

    def solved_set?(tiles)
        nums=tiles.map(&:value)
        nums.sort == (1..9).to_a
    end

    def size
        @grid.size
    end

    def square(idx)
        tiles=[]
        x=(idx/3)*3
        y=(idx%3)*3
        (x...x+3).each do |i|
            (y...y+3).each do |j|
                tiles<<self[[i,j]]
            end
        end
        tiles
    end

    def squares
        (0..8).to_a.map{|indexes| square(indexes)}
    end


end