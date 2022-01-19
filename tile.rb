require 'colorize'
class Tile

    attr_reader :value

    def initialize(value)
        @value=value
        @given=value == 0 ? false : true
    end

    def color
        given? ? :light_blue : :red
    end

    def given?
        @given
    end

    def to_s
        @value == 0 ? " " : value.to_s.colorize(color)
    end

    def value=(new_value)
        if given?
            puts "You can not change a given value tike"
        else
            @value=new_value
        end
    end
end


# def render
#     puts "    #{(0...f.length).to_a.join(" ")}"
#     puts "----------------------"
#     f.each_with_index do |row,i|
#         puts "#{i} | #{row.join(" ")}"
#     end
# end

# f=File.readlines('./puzzles/sudoku1.txt').map!{|line| line.split("")}.map!{|arr| arr.each{|ele| arr.delete(ele) if ele=="\n"}}
# positions=[]
# f.each_with_index {|row,i|(0...row.length).each{|j|positions<<[i,j] if f[i][j] != "0"}}
# p positions