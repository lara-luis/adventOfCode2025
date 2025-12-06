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

      line = line.gsub("\n", '')
      next if line.strip.chomp.empty?

      line_array = line.split('')
      line_array.each_with_index do |num, index|
        @numbers[index] ||= []
        @numbers[index] << num.gsub(' ', '-')
      end
    end
  end

  def transform_numbers(array)
    array.dup
    new_number_array = []

    @numbers.each do |num|
      num = num.join.to_s.gsub('-', '').to_i
      new_number_array << num
    end
    new_number_array
  end

  def group
    groups = []
    acc = []

    @numbers.each do |arr|
      if arr.uniq.size <= 1 && arr.uniq[0] == '-'
        groups << acc
        acc = []
      else
        acc << arr.join.to_s.gsub('-', '').to_i
      end
    end
    groups << acc unless acc.empty?
    groups
  end

  def calculate_problems
    total = 0
    grouped_numbers = group

    grouped_numbers.each_with_index do |number, index|
      operator = @operators[index].to_sym
      transf_numbers = number
      result = transf_numbers.reduce(operator)
      total += result
    end
    total
  end
end

day6 = Day6.new
day6.read_file
puts day6.calculate_problems
