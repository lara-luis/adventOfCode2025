# frozen_string_literal: true

class Day2
  def collect_ranges
    ranges = []

    File.foreach('Day2\\input2.txt', 'r') do |line|
      ranges = line.strip.split(',').map do |range|
        bounds = range.split('-').map(&:to_i)
        [bounds[0], bounds[1]]
      end
    end
    ranges
  end

  def sum_invalid_ids(ranges)
    invalid_sum = 0

    ranges.each do |range|
      lower_bound, upper_bound = range
      (lower_bound..upper_bound).each do |num|
        is_invalid = invalid?(num)
        invalid_sum += num if is_invalid
      end
    end
    invalid_sum
  end

  def invalid?(num)
    is_invalid = false
    max_repetitions = num.to_s.size

    2.upto(max_repetitions) do |i|
      next unless (num.to_s.size % i).zero?

      parts = num.to_s.chars.each_slice(num.to_s.size / i).map(&:join)
      is_invalid ||= (parts.uniq.size == 1)
    end

    is_invalid
  end
end

day2 = Day2.new
ranges = day2.collect_ranges
puts day2.sum_invalid_ids(ranges)
