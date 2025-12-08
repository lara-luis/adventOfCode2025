# frozen_string_literal: true

class Day7
  attr_reader :map, :starting_pos

  def initialize
    @map = []
    @starting_pos = []
    @visited = []
  end

  def read_file
    File.readlines('Day7\\input7.txt').each do |line|
      @map << line.chomp.split('')
      @starting_pos = [line.chomp.split('').index('S'), 0] if line.include?('S')
    end
  end

  def navigate_map(pos)
    x, y = pos
    return 0 if y == @map.size - 1 || x.negative? || x >= @map[0].size
    return 0 if @visited.include?(pos)

    @visited << pos

    down_pos = [x, y + 1]
    if map[down_pos[1]][down_pos[0]] == '^'
      @map[y][x] = '|'
      left_pos = [down_pos[0] - 1, down_pos[1]]
      right_pos = [down_pos[0] + 1, down_pos[1]]
      left = @map[left_pos[1]][left_pos[0]] != '|' ? navigate_map(left_pos) : 0
      right = @map[right_pos[1]][right_pos[0]] != '|' ? navigate_map(right_pos) : 0

      left + right + 1
    else
      @map[y][x] = '|'
      navigate_map(down_pos)
    end
  end
end

day7 = Day7.new
day7.read_file
puts day7.navigate_map(day7.starting_pos)
