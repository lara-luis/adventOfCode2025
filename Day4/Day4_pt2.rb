# frozen_string_literal: true

class Day4
  def initialize
    @map = []
  end

  def read_map
    File.readlines('Day4\\input4.txt').each do |line|
      @map << line.chomp.chars
    end
  end

  def count_roles
    removed_roles = 0
    
    @map.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        next unless cell == '@'

        surrounding_roles = 0

        surrounding_roles += 1 if i.positive? && j.positive? && @map[i - 1][j - 1] == '@' # Top-left
        surrounding_roles += 1 if i.positive? && @map[i - 1][j] == '@'               # Top
        surrounding_roles += 1 if i.positive? && j < row.length - 1 && @map[i - 1][j + 1] == '@' # Top-right
        surrounding_roles += 1 if j.positive? && @map[i][j - 1] == '@'               # Left
        surrounding_roles += 1 if j < row.length - 1 && @map[i][j + 1] == '@' # Right
        surrounding_roles += 1 if i < @map.length - 1 && j.positive? && @map[i + 1][j - 1] == '@' # Bottom-left
        surrounding_roles += 1 if i < @map.length - 1 && @map[i + 1][j] == '@' # Bottom
        surrounding_roles += 1 if i < @map.length - 1 && j < row.length - 1 && @map[i + 1][j + 1] == '@' # Bottom-right

        @map[i][j] = 'x' if surrounding_roles < 4
        removed_roles += 1 if surrounding_roles < 4
      end
    end

    removed_roles
  end 

  def removed_roles
    removed_roles_total = 0
    loop do
      removed_this_round = count_roles
      break if removed_this_round.zero?

      removed_roles_total += removed_this_round
    end
    removed_roles_total
  end
end

day4 = Day4.new
day4.read_map
puts day4.removed_roles
