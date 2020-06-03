# frozen_string_literal: true

require_relative 'node'
require 'pry'

# binary search tree
class Tree
  attr_accessor :root

  def initialize(array)
    # @array = array.sort.uniq
    @root = build_tree(array.sort.uniq)
  end

  def empty?
    @root.nil?
  end

  def build_tree(arr)
    return Node.new(arr.first) if arr.length < 2

    mid = arr.length / 2
    root = Node.new(arr[mid])
    root.left = build_tree(arr.take(mid))
    root.right = build_tree(arr.drop(mid + 1)) unless arr.drop(mid + 1).empty?
    root
  end

  def display
    levels = depth_recursion(@root)
    if levels > 5
      puts "Can only display up to 5 levels. Current # of levels: #{levels}"
      return
    end
    66.times { print '-' }
    2.times { puts }
    queue = []
    return if empty?

    blank = Node.new('--')
    blank.left = blank
    blank.right = blank
    level = 0
    i = 0
    n_blanks = 32
    n_blanks.times { print ' ' }
    queue << @root
    until queue.empty?
      current = queue.shift
      queue << (current.left || blank)
      queue << (current.right || blank)
      print current.value
      (n_blanks * 2 - 2).times { print ' ' }
      i += 1
      if i == 2**(level + 1) - 1
        puts
        break if queue.all?(blank)
        level += 1
        n_blanks /= 2
        n_blanks.times { print ' ' }  
      end
    end
    puts
    66.times { print '-' }
    puts
  end

  def insert(value)
    new_node = Node.new(value)
    if empty?
      @root = new_node
    elsif find(value)
      false
    else
      current = @root
      until current.nil?
        parent = current
        current = new_node < current ? current.left : current.right
      end
      new_node < parent ? parent.left = new_node : parent.right = new_node
    end
  end

  def delete(key)
    return false if empty?

    current = @root
    until current.value == key
      parent = current
      current = key < current.value ? current.left : current.right
      return false if current.nil?
    end
    # node to be deleted has no children
    if current.left.nil? && current.right.nil?
      @root = nil if current == @root
      current < parent ? parent.left = nil : parent.right = nil
    # node to be deleted has one child
    elsif current.right.nil?
      @root = current.left if current == @root
      current < parent ? parent.left = current.left : parent.right = current.left
    elsif current.left.nil?
      @root = current.right if current == @root
      current < parent ? parent.left = current.right : parent.right = current.right
    # node to be deleted has two children
    else
      successor = get_successor(current)
      @root = successor if current == @root
      current < parent ? parent.left = successor : parent.right = successor
      successor.left = current.left
    end
  end

  def find(key)
    return false if empty?

    current = @root
    until current.value == key
      current = key < current.value ? current.left : current.right
      return false if current.nil?
    end
    current
  end

  def level_order
    array = []
    queue = []
    return array if empty?

    queue << @root
    until queue.empty?
      current = queue.shift
      queue << current.left unless current.left.nil?
      queue << current.right unless current.right.nil?
      array << current.value
    end
    return array unless block_given?

    array.each { |item| yield item }
  end

  # same method as above, using recursion
  def level_order_alt
    return [] if empty?

    array = level_order_rec([@root])
    return array unless block_given?

    array.each { |item| yield item }
  end

  def in_order
    return [] if empty?

    array = []
    in_order_rec(@root, array)
    return array unless block_given?

    array.each { |item| yield item }
  end

  def pre_order
    return [] if empty?

    array = []
    pre_order_rec(@root, array)
    return array unless block_given?

    array.each { |item| yield item }
  end

  def post_order
    return [] if empty?

    array = []
    post_order_rec(@root, array)
    return array unless block_given?

    array.each { |item| yield item }
  end

  # Node class is only visible to Tree class
  def depth(key)
    key_node = find(key)
    return false unless key_node

    depth_recursion(key_node)
  end

  def balanced?
    return false if empty?

    balanced_rec(@root)
  end

  def rebalance
    @root = build_tree(in_order)
  end

  private

  # assumes node has two children
  def get_successor(node)
    successor = node
    current = node.right
    until current.nil?
      parent = successor
      successor = current
      current = current.left
    end
    # two additional connections if successor is not deleted node's right child
    unless successor == node.right
      parent.left = successor.right
      successor.right = node.right
    end
    successor
  end

  def level_order_rec(queue, array = [])
    return array if queue.empty?

    current = queue.shift
    queue << current.left unless current.left.nil?
    queue << current.right unless current.right.nil?
    array << current.value
    level_order_rec(queue, array)
  end

  def in_order_rec(local_root, array)
    return if local_root.nil?

    in_order_rec(local_root.left, array)
    array << local_root.value
    in_order_rec(local_root.right, array)
  end

  def pre_order_rec(local_root, array)
    return if local_root.nil?

    array << local_root.value
    pre_order_rec(local_root.left, array)
    pre_order_rec(local_root.right, array)
  end

  def post_order_rec(local_root, array)
    return if local_root.nil?

    post_order_rec(local_root.left, array)
    post_order_rec(local_root.right, array)
    array << local_root.value
  end

  def depth_recursion(local_root)
    return -1 if local_root.nil?

    left_depth = 1 + depth_recursion(local_root.left)
    right_depth = 1 + depth_recursion(local_root.right)
    left_depth > right_depth ? left_depth : right_depth
  end

  def balanced_rec(local_root)
    return false unless (depth_recursion(local_root.left) -
                        depth_recursion(local_root.right)).abs <= 1

    if local_root.left
      return false unless balanced_rec(local_root.left)
    end
    if local_root.right
      return false unless balanced_rec(local_root.right)
    end
    true
  end
end
