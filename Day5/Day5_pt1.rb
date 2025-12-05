# frozen_string_literal: true

class Day5
  def initialize
    @fresh_ingredients = []
    @ingredients_to_analyze = []
  end

  def read_ingredients
    File.readlines('Day5\\input5.txt').each do |line|
      if line.include?('-')
        line.chomp.split('-').each_cons(2) do |start, finish|
          @fresh_ingredients << [start.to_i, finish.to_i]
        end
      else
        @ingredients_to_analyze << line.chomp.to_i if !line.chomp.empty?
      end
    end
  end

  def count_fresh_ingredients
    fresh_count = 0
    @ingredients_to_analyze.each do |ingredient|
      @fresh_ingredients.each do |range|
        if ingredient >= range[0] && ingredient <= range[1]
          fresh_count += 1
          break
        end
      end
    end
    fresh_count
  end

end

day5 = Day5.new
day5.read_ingredients
puts day5.count_fresh_ingredients
