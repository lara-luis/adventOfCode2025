# frozen_string_literal: true

class Day8
  CONNECTIONS = 10000000

  def initialize
    @boxes = []
    @distances = Set.new
    @groups = []
    @the_last_merge = nil
    @mapped_boxes = []
  end 

  def read_input
    File.readlines('Day8\\input8.txt').each do |line|
      @boxes << line.chomp.split(',').map(&:strip).map(&:to_i)
    end
  end

  def calculate_distance(p1, p2)
    Math.sqrt((p1[0] - p2[0])**2 + (p1[1] - p2[1])**2 + (p1[2] - p2[2])**2)
  end 

  def find_nearest_box
    @boxes.each_with_index do |box, index|
      distances = []
      @boxes.each_with_index do |other_box, other_index|
        next if index == other_index

        distance = calculate_distance(box, other_box)
        min_index = [index, other_index].min
        max_index = [index, other_index].max
        @distances << [min_index, max_index, distance]
      end
    end
  end

  def find_already_in_group(box_index)
    @groups.each_with_index do |group, index|
      return index if group.include?(box_index)
    end
    -1
  end 

  def form_groups 
    find_nearest_box

    @distances = @distances.sort_by { |sub| sub[2] }

    @groups = []
    (CONNECTIONS).times do |i|
      next_distance = @distances.shift
      existing_group_index = find_already_in_group(next_distance[0])
      other_existing_group_index = find_already_in_group(next_distance[1])

      next if existing_group_index == other_existing_group_index && existing_group_index != -1

      if existing_group_index != -1 && other_existing_group_index != -1
        @groups[existing_group_index].concat @groups[other_existing_group_index]
        @groups.delete_at(other_existing_group_index)
      elsif existing_group_index != -1
        @groups[existing_group_index] << next_distance[1]
      elsif other_existing_group_index != -1
        @groups[other_existing_group_index] << next_distance[0]
      else
        @groups << [@boxes[next_distance[0]], @boxes[next_distance[1]]]
      end

      @mapped_boxes << @boxes[next_distance[0]]
      @mapped_boxes << @boxes[next_distance[1]]
      @the_last_merge = [@boxes[next_distance[0]], @boxes[next_distance[1]]] if @mapped_boxes.uniq.size == @boxes.size
      break if @mapped_boxes.uniq.size == @boxes.size
    end
    @groups 
  end 

  def multiply_last_group
    c1 = @the_last_merge[0][0]
    c2 = @the_last_merge[1][0]
    c1 * c2
  end 
end

day8 = Day8.new
day8.read_input
day8.form_groups
puts day8.multiply_last_group