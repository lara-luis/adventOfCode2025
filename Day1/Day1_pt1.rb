class Day1 
  MAX_NUMBER = 99
  MIN_NUMBER = 0

  def initialize
    @curr_number = 50
  end
  
  def count_0
    reached_0 = 0

    File.open("Day1\\input1.txt", "r") do |f|
      f.each_line do |line|
      instructions = line.chars
      direction = instructions[0]
      steps = instructions[1..].join.to_i

      if direction == "L"
        @curr_number -= steps
        @curr_number += 100 while @curr_number < MIN_NUMBER
        reached_0 += 1 if @curr_number == 0
      end

      if direction == "R"
        @curr_number += steps
        @curr_number -= 100 while @curr_number > MAX_NUMBER
        reached_0 += 1 if @curr_number == 0
      end
    end
    reached_0
  end 
end 
end 

day1 = Day1.new()
puts day1.count_0