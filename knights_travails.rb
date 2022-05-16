# frozen_string_literal: false

# rubocop:disable MethodLength, AbcSize, CyclomaticComplexity

# class for each Node
class Node
  attr_accessor :x, :y, :distance

  def initialize(val_x, val_y, distance)
    @x = val_x
    @y = val_y
    @distance = distance
  end
end

# class for the script
class Game
  def knight_moves(current_tile, end_tile, counter = 30)
    moves_x = [-2, -1, 1, 2, -2, -1, 1, 2]
    moves_y = [-1, -2, -2, -1, 1, 2, 2, 1]
    queue = []

    queue.push(Node.new(current_tile[0], current_tile[1], 0))

    visited = Array.new(counter + 1)

    counter.times do |i|
      visited[i] = Array.new(counter + 1)
      counter.times do |j|
        visited[i][j] = false
      end
    end

    visited[current_tile[0]][current_tile[1]] = true

    until queue.empty?
      t = queue.shift

      return t.distance if t.x == end_tile[0] && t.y == end_tile[1]

      8.times do |i|
        x = t.x + moves_x[i]
        y = t.y + moves_y[i]

        if inside?(x, y, counter) && !visited[x][y]
          visited[x][y] = true
          queue.push(Node.new(x, y, t.distance + 1))
        end
      end
    end
  end

  def inside?(val_x, val_y, distance)
    if val_x >= 1 && val_x <= distance && val_y >= 1 && val_y <= distance
      true
    else
      false
    end
  end
end

knight = Game.new
puts knight.knight_moves([1, 1], [7, 7])


# knight into eight possible moves
# each move into another eight possible moves
# if any of those lands on the desired tile, end
