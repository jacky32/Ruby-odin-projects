# frozen_string_literal: true

require 'pry'

class Node # rubocop:todo Style/Documentation
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

# rubocop:todo Style/Documentation
class LinkedList # rubocop:todo Metrics/ClassLength, Style/Documentation
  # rubocop:enable Style/Documentation
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    if @tail.nil?
      @tail = Node.new(value)
    else
      new_tail = Node.new(value)
      @tail.next_node = new_tail
      @tail = new_tail
    end
    @head = @tail if @head.nil?
  end

  def prepend(value)
    @head = if @head.nil?
              Node.new(value)
            else
              Node.new(value, @head)
            end
    @tail = @head if @tail.nil?
  end

  def size
    return 0 if @head.nil?

    counter = 0
    current = @head
    until current.nil?
      current = current.next_node
      counter += 1
    end
    counter
  end

  def at(index)
    return 'Error' if index > size

    counter = 1
    current = @head
    until counter == index
      current = current.next_node
      counter += 1
    end
    current
  end

  def pop
    return 'Error' if @tail.nil?

    @tail = at(size - 1)
    @tail.next_node = nil
  end

  def contains?(value)
    return 'Error' if @head.nil?

    current = @head
    until current.next_node.nil?
      return true if current.value == value

      current = current.next_node
    end
    false
  end

  def find(value)
    return 'Error' if @head.nil?

    current = @head
    counter = 1
    until current.next_node.nil?
      return counter if current.value == value

      current = current.next_node
      counter += 1
    end
    nil
  end

  def to_s
    return 'Error' if @head.nil?

    current = @head
    string = ''
    until current.nil?
      string = "#{string}( #{current.value} ) -> "
      current = current.next_node
    end
    "#{string}nil"
  end

  def insert_at(value, index) # rubocop:todo Metrics/MethodLength
    return 'Error' if index > size

    case index
    when 1
      prepend(value)
    when size
      append(value)
    else
      before_node = at(index - 1)
      after_node = at(index)
      before_node.next_node = Node.new(value, after_node)
    end
  end

  def remove_at(index)
    return 'Error' if index > size

    if index == size
      pop
    elsif index == 1
      @head = @head.next_node
    else
      before_node = at(index - 1)
      after_node = at(index + 1)
      before_node.next_node = after_node
    end
  end
end

list = LinkedList.new

list.append('b')
list.append('c')
list.append('d')
list.append('e')
list.append('f')
list.prepend('a')
list.insert_at('3', 3)
list.insert_at('6', 6)
puts list.contains?('c')
puts list.contains?('cd')
puts list.find('c')
puts list.find('cd')
puts list.to_s
list.remove_at(3)
puts list.to_s
