#!/usr/bin/env ruby

filename = ARGV.shift

exit 1 unless File.exist? filename

class Magician
  def initialize
    @possible_choose = (1..16).to_a.map(&:to_s)
  end

  def choose cards, choose
    cards.map!(&:strip)
    @possible_choose &= cards[choose-1].split
  end

  def result
    case @possible_choose.size
    when 0
      %/Volunteer cheated!/
    when 1
      @possible_choose.first
    else
      %/Bad magician!/
    end
  end
end

open filename, 'r' do |f|
  num_of_cases = f.readline.strip.to_i
  num_of_cases.times do |t|
    mag = Magician.new

    2.times do
      choose = f.readline.strip.to_i
      cards  = f.each_slice(4).first

      mag.choose cards, choose
    end
    puts "Case ##{t+1}: #{mag.result}"
  end
end

