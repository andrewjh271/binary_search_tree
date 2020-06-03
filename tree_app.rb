# frozen_string_literal: true

require_relative 'tree'
require_relative 'node'

# Tests binary search tree
class TreeApp
  tree = Tree.new(Array.new(20) { rand(1...100) })
  # tree = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14])
  tree.display
  puts "Balanced? #{tree.balanced?}"
  puts "Preorder: #{tree.preorder}"
  puts "Inorder: #{tree.inorder}"
  puts "Postorder: #{tree.postorder}"
  puts "Level order: #{tree.level_order}"
  10.times { tree.insert(rand(100...150)) }
  (20..30).each { |i| tree.delete(i) }
  tree.display
  puts "Balanced? #{tree.balanced?}"
  tree.rebalance
  tree.display
  puts "Depth: #{tree.depth + 1}"
  puts "Balanced? #{tree.balanced?}"
  puts "Preorder: #{tree.preorder}"
  puts "Inorder: #{tree.inorder}"
  puts "Postorder: #{tree.postorder}"
  puts "Level order: #{tree.level_order}"
  puts "Testing blocks..."
  puts tree.preorder { |v| (v.value / 30).times { print 'HI' } }
  puts tree.inorder { |v| print "#{v.value * 10} " }
  puts tree.postorder { |v| print "#{v.value + 10} " }
end
