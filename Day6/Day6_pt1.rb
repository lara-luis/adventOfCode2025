# frozen_string_literal: true

class Day6
  def initialize
    @numbers = []
    @operators = []
  end

  def read_file
    File.readlines('Day6\\input6.txt').each do |line|
      if line.include?('+') || line.include?('*')
        @operators = line.chomp.split(' ')
        next
      end

      line_array = line.chomp.split(' ').map(&:to_i)
      line_array.each_with_index do |num, index|
        @numbers[index] ||= []
        @numbers[index] << num
      end
    end
  end

  def calculate_problems
    total = 0
    @numbers.each_with_index do |number, index|
      operator = @operators[index].to_sym
      result = number.reduce(operator)
      total += result
    end
    total
  end
end

day6 = Day6.new
day6.read_file
puts day6.calculate_problems
