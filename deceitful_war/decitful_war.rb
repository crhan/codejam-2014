#!/usr/bin/env ruby
#require 'pry'

filename = ARGV.shift

exit 1 unless File.exist? filename

class Game
  def initialize input
    input.shift
    @naomi = input.shift.split.map(&:to_f).sort.reverse
    @ken   = input.shift.split.map(&:to_f).sort.reverse
  end

  def deceitful_war
    naomi = @naomi.clone
    ken   = @ken.clone
    score = 0

    naomi.each do |n|
      if tmp = ken.find {|k| k < n }
        ken.delete(tmp)
        score += 1
      end
    end

    return score
  end

  def war
    naomi = @naomi.clone
    ken   = @ken.clone
    score = 0

    ken.each do |k|
      if tmp = naomi.find {|n| n < k }
        naomi.delete(tmp)
      else
        score += 1
      end
    end

    return score
  end
end


open filename, 'r' do |f|
  num_of_cases = f.readline.strip.to_i
  num_of_cases.times do |t|
    game = Game.new f.each_slice(3).first
    #binding.pry

    puts "Case ##{t+1}: #{game.deceitful_war} #{game.war}"
  end
end
