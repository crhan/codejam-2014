#!/usr/bin/env ruby
filename = ARGV.shift
#require 'pry'

exit 1 unless File.exist? filename

class Board
  def initialize width, height, mine_count
    @width, @height, @mine_count = width, height, mine_count
    @board = Array.new(width, Array.new(height){"*"})
  end

  def to_s
    @board.map do |row|
      row.join(" ")
    end.join("\n")
  end
end

open filename, 'r' do |f|
  num_of_cases = f.readline.strip.to_i
  num_of_cases.times do |t|
    w,h,m = f.readline.strip.split.map(&:to_i)
    board = Board.new w,h,m

    #puts "Case ##{t+1}: #{mag.result}"
    puts
    puts board.to_s
  end
end
