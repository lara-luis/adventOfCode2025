# frozen_string_literal: true

class Day3
  def find_largest_jolt
    jolts_sum = 0

    File.open('Day3\\input3.txt', 'r') do |f|
      f.each_line do |line|
        jolts = line.chars.map(&:to_i)
        max_jolt = jolts[0..jolts.size - 3].max
        max_jolt_index = jolts.index(max_jolt)
        second_max_jolt = jolts[max_jolt_index + 1..jolts.size - 1].max
        resulting_jolt = max_jolt.to_s + second_max_jolt.to_s
        jolts_sum += resulting_jolt.to_i
      end
    end
    jolts_sum
  end
end

day3 = Day3.new
puts day3.find_largest_jolt
