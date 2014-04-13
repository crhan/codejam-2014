#!/usr/bin/env ruby
#require 'pry'

filename = ARGV.shift

exit 1 unless File.exist? filename

class CookieClicker
  def initialize c, f, x
    @cost = c
    @step_increase = f
    @goal = x
    @time = 0.0
    @init_rate = 2.0
  end

  def farms
    @farms ||= ( @goal / @cost - @init_rate / @step_increase ).floor
  end

  def time
    if farms < 1
      @goal / @init_rate
    else
      ( 1..farms ).reduce(0.0) { |memo, f| memo + calc_time(f) }
    end
  end

  private

  def calc_time farm_num
    t = @cost / speed(farm_num - 1)
    t += @goal / speed(farm_num) if farm_num == farms
    #puts "farm_num #{farm_num}: #{t}"
    t
  end

  def speed farm_num
    @init_rate + farm_num * @step_increase
  end
end

open filename, 'r' do |f|
  num_of_cases = f.readline.strip.to_i
  num_of_cases.times do |t|
    cc = CookieClicker.new( *f.readline.split.map(&:to_f) )
    #binding.pry

    puts "Case ##{t+1}: #{sprintf '%.8f', cc.time}"
  end
end

