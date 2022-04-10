# frozen_string_literal: false
# rubocop:disable ClassLength

require 'pry'
# class for each node
class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

# class for the entire tree
class Tree
  def initialize(arr)
    @array = arr.sort.uniq
    @root = build_tree(@array)
  end

  def build_tree(arr)
    return nil if arr.empty?

    mid = (arr.size - 1) / 2
    root = Node.new(arr[mid])

    root.left = build_tree(arr[0...mid])
    root.right = build_tree(arr[(mid + 1)..-1])
    root
  end

  def insert(value, current = @root)
    if current.nil?
      current = Node.new(value)
      return current
    end

    if value > current.data
      current.right = insert(value, current.right)
    else
      current.left = insert(value, current.left)
    end

    current
  end

  def delete(value, current = @root)
    # base case
    return current if current.nil?

    # recurse down
    if value < current.data
      current.left = delete(value, current.left)
    elsif current.data < value
      current.right = delete(value, current.right)
    # same value
    else
      # one child
      return current.right if current.left.nil?
      return current.left if current.right.nil?
      # two children
      current.data = min_value(current.right).data
      current.right = delete(current.data, current.right)
    end
    current
  end

  def min_value(current)
    min_val = current.data
    until current.left.nil?
      min_val = current.left.data
      current = current.left
    end
    min_val
  end

  def find(value, current = @root)
    # value doesn't exist in the tree
    return nil if current.nil?

    # base case
    return current if value == current.data

    # recurse down
    return find(value, current.right) if value > current.data
    return find(value, current.left) if value < current.data
  end

  def level_order(queue = [], node_values = [], current = @root)
    loop do
      queue << current.left unless current.left.nil?
      queue << current.right unless current.right.nil?
      node_values.push(current.data)
      break if queue.empty?

      current = queue.shift
    end
    node_values
  end

  def inorder(node_values = [], current = @root)
    return if current.nil?

    inorder(node_values, current.left)
    node_values.push(current.data)
    inorder(node_values, current.right)
    node_values
  end

  def preorder(node_values = [], current = @root)
    return if current.nil?

    node_values.push(current.data)
    preorder(node_values, current.left)
    preorder(node_values, current.right)
    node_values
  end

  def postorder(node_values = [], current = @root)
    return if current.nil?

    postorder(node_values, current.left)
    postorder(node_values, current.right)
    node_values.push(current.data)
    node_values
  end

  # gets the distance from value to the root
  def depth(value, current = @root, counter = 1)
    # value doesn't exist in the tree
    return nil if current.nil?

    # base case
    return counter if value == current.data

    # recurse down
    return depth(value, current.right, counter += 1) if value > current.data
    return depth(value, current.left, counter += 1) if value < current.data
  end

  # gets the distance from the value to the deepest leaf in its subtree
  def height(value, current = find(value))
    return nil if find(value).nil?
    return 0 if current.nil?

    left_tree = height(value, current.left)
    right_tree = height(value, current.right)

    [left_tree, right_tree].max + 1
  end

  def balanced?
    
  end

  def rebalance
    @root = build_tree(inorder)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

strom = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 54, 63, 122, 502])
strom.pretty_print
strom.insert(120)
strom.pretty_print
strom.delete(120)
strom.delete(3)
strom.pretty_print
p strom.find(7).data
p strom.find(502).data
p strom.find(63).data
p strom.find(7123)
p strom.level_order
p strom.inorder
p strom.preorder
p strom.postorder
p strom.depth(7)
p strom.depth(9)
p strom.depth(122)
p strom.height(4)
p strom.height(9)
p strom.height(12)
strom.rebalance
strom.pretty_print
