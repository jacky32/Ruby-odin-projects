require 'pry' 

class Node
  attr_accessor :value, :next_node
  def initialize (value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end


class LinkedList
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    if @tail == nil
      @tail = Node.new(value)
    else
      new_tail = Node.new(value)
      @tail.next_node = new_tail
      @tail = new_tail
    end
    if @head == nil
      @head = @tail
    end
  end

  def prepend(value)
    if @head == nil
      @head = Node.new(value)
    else
      @head = Node.new(value, @head)
    end
    if @tail == nil
      @tail = @head
    end
  end

  def size
    return 0 if @head == nil
    counter = 0
    current = @head
    until current == nil
      current = current.next_node
      counter += 1
    end
    return counter
  end

  def at(index)
    return "Error" if index > self.size
    counter = 1
    current = @head
    until counter == index
      current = current.next_node
      counter += 1
    end
    return current
  end

  def pop
    return "Error" if @tail == nil
    @tail = self.at(self.size-1)
    @tail.next_node = nil
  end

  def contains?(value)
    return "Error" if @head == nil
    current = @head
    until current.next_node == nil
      return true if current.value == value
      current = current.next_node
    end
    return false
  end

  def find(value)
    return "Error" if @head == nil
    current = @head
    counter = 1
    until current.next_node == nil
      return counter if current.value == value
      current = current.next_node
      counter += 1
    end
    return nil
  end

  def to_s
    return "Error" if @head == nil
    current = @head
    string = ""
    until current == nil
      string = "#{string}( #{current.value} ) -> " 
      current = current.next_node
    end
    return string + "nil"
  end

  def insert_at(value, index)
    return "Error" if index > self.size
    if index == 1
      self.prepend(value)
    elsif index == self.size
      self.append(value)
    else
      before_node = self.at(index-1)
      after_node = self.at(index)
      before_node.next_node = Node.new(value,after_node)
    end
  end

  def remove_at(index)
    return "Error" if index > self.size
    if index == self.size
      self.pop
    elsif index == 1
      @head = @head.next_node
    else
      before_node = self.at(index-1)
      after_node = self.at(index+1)
      before_node.next_node = after_node
    end
  end
end


list = LinkedList.new

list.append("b")
list.append("c")
list.append("d")
list.append("e")
list.append("f")
list.prepend("a")
list.insert_at("3", 3)
list.insert_at("6", 6)
puts list.contains?("c")
puts list.contains?("cd")
puts list.find("c")
puts list.find("cd")
puts list.to_s
list.remove_at(3)
puts list.to_s