class Node
  attr_accessor :data, :left, :right
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  def initialize(arr)
    @array = arr.sort.uniq
    @root = build_tree(@array)
  end

  def build_tree(arr)
    return nil if arr.empty?
    mid = (arr.size-1)/2
    root = Node.new(arr[mid])

    root.left = build_tree(arr[0...mid])
    root.right = build_tree(arr[(mid+1)..-1])
    return root
  end

  def insert(value, current = @root)
    if current == nil
      current = Node.new(value)
      return current
    end

    if value > current.data
      current.right = insert(value, current.right)
    else
      current.left = insert(value, current.left)
    end

    return current
  end

  def delete(value)

  end

  def find(value)

  end

  def level_order(&block)
  
  end

  def inorder(&block)

  end

  def preorder(&block)

  end

  def postorder(&block)

  end

  def height(node)

  end

  def depth(node)

  end

  def balanced?

  end

  def rebalance

  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end


strom = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 54, 63, 122, 502])
strom.pretty_print
strom.insert(12012012)
strom.pretty_print