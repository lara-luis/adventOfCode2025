# frozen_string_literal: true

class Day9

  def initialize
    @coords = Set.new
  end

  def read_file
    File.readlines('Day9\\input9.txt').each do |line|
      @coords << line.chomp.split(',').map(&:to_i)
    end
  end

  def calculate_rectangles
    max_rectangle = -1

    @coords.each do |(x1, y1)|
      @coords.each do |(x2, y2)|
        next if x2 == x1 && y2 == y1
        #puts "Comparing (#{x1}, #{y1}) and (#{x2}, #{y2})"
        rectangle_count = (y2 - y1 + 1).abs * (x2 - x1 + 1).abs
        #puts "Rectangle count: #{rectangle_count}"
        max_rectangle = rectangle_count if rectangle_count > max_rectangle
      end
    end
    max_rectangle
  end 
end

day9 = Day9.new
day9.read_file
puts day9.calculate_rectangles
