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

      starting_number = @curr_number

      if direction == "L"
        reached_0 += (steps / 100).to_i
        @curr_number -= steps % 100
        has_rounds = false

        while @curr_number < MIN_NUMBER do 
          @curr_number += 100 
          reached_0 += 1
          has_rounds = true
        end

        reached_0 -= 1 if starting_number == MIN_NUMBER && has_rounds
        reached_0 += 1 if @curr_number == MIN_NUMBER && !has_rounds
      end

      if direction == "R"
        reached_0 += (steps / 100).to_i
        @curr_number += steps % 100

        has_rounds = false

        while @curr_number > MAX_NUMBER do
          @curr_number -= 100 
          reached_0 += 1
          has_rounds = true
        end 

        reached_0 -= 1 if starting_number == MIN_NUMBER && has_rounds
        reached_0 += 1 if @curr_number == MIN_NUMBER && !has_rounds
      end
    end
    reached_0
  end 
end 
end 

day1 = Day1.new()
puts day1.count_0