# frozen_string_literal: true

class Day3
  JOLT_SIZE = 12

  def find_largest_jolt
    jolts_sum = 0
    size = JOLT_SIZE
    resulting_jolt = ''

    File.open('Day3\\input3.txt', 'r') do |f|
      f.each_line do |line|
        jolts = line.gsub("\n", '').chars.map(&:to_i)
        resulting_jolt = ''
        size = JOLT_SIZE
        min_jolt_index = 0
        size.times do |_i|
          max_jolt_index = jolts.size - size
          max_jolt = jolts[min_jolt_index..max_jolt_index].max
          jolt_index = jolts[min_jolt_index..max_jolt_index].index(max_jolt)
          min_jolt_index += jolt_index + 1
          resulting_jolt += max_jolt.to_s
          size -= 1
        end
        jolts_sum += resulting_jolt.to_i
      end
    end
    jolts_sum
  end
end

day3 = Day3.new
puts day3.find_largest_jolt
