class Day2 
  def initialize
  end
  
  def collect_ranges
    ranges = []

    File.foreach("Day2\\input2.txt", "r") do |line|
      ranges = line.strip.split(",").map do |range|
        bounds = range.split("-").map(&:to_i)
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
        is_invalid = is_invalid?(num)
        invalid_sum += num if is_invalid
      end
    end 
    invalid_sum
  end

  def is_invalid?(num)
    is_invalid = false
    max_repetitions = num.to_s.size

    2.upto(max_repetitions) do |i|
      if (num.to_s.size % i == 0)
        parts = num.to_s.chars.each_slice(num.to_s.size / i).map(&:join)
        #puts "Checking number #{num} with parts #{parts.inspect} for repetition of size #{i} #{parts.uniq.size == 1 ? '-> INVALID' : '-> valid'}"
        is_invalid = is_invalid || (parts.uniq.size == 1)
      end
    end

    is_invalid
  end
end 

day2 = Day2.new()
ranges = day2.collect_ranges
puts day2.sum_invalid_ids(ranges)