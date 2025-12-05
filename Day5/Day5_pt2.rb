# frozen_string_literal: true

class Day5
  def initialize
    @fresh_ingredients = []
    @ingredients_to_analyze = []
  end

  def read_ingredients
    File.readlines('Day5\\input5.txt').each do |line|
      next unless line.include?('-')

      line.chomp.split('-').each_cons(2) do |start, finish|
        @fresh_ingredients << [start.to_i, finish.to_i]
      end
    end
    @fresh_ingredients
  end

  def recalculate_fresh_ingredients_ranges(ranges)
    overlaps = false
    new_ranges = []
    stack = ranges.dup

    until stack.empty?
      range_a = stack.pop

      stack.each_with_index do |range_b, i|
        next unless range_b[0] <= range_a[1] && range_a[0] <= range_b[1]

        overlaps = true
        new_min = [range_a[0], range_b[0]].min
        new_max = [range_a[1], range_b[1]].max
        stack << [new_min, new_max]
        stack.delete_at(i)
      end
      new_ranges << range_a unless overlaps
      overlaps = false
    end
    new_ranges
  end

  def count_fresh_ingredients(ranges)
    count = 0
    ranges.each do |range|
      count += (range[1] - range[0] + 1)
    end
    count
  end
end

day5 = Day5.new
ingredients = day5.read_ingredients
final_ranges = day5.recalculate_fresh_ingredients_ranges(ingredients)
puts day5.count_fresh_ingredients(final_ranges)
