# frozen_string_literal: true

require_relative 'tree'

# Tests binary search tree
class TreeApp
  tree = Tree.new(Array.new(20) { rand(1...100) })
  tree.display
  puts "Balanced? #{tree.balanced?}"
  puts "Preorder: #{tree.pre_order}"
  puts "Inorder: #{tree.in_order}"
  puts "Postorder: #{tree.post_order}"
  puts "Level order: #{tree.level_order}"
  7.times { tree.insert(rand(100...150)) }
  tree.display
  puts "Balanced? #{tree.balanced?}"
  tree.rebalance
  tree.display
  puts "Balanced? #{tree.balanced?}"
  puts "Preorder: #{tree.pre_order}"
  puts "Inorder: #{tree.in_order}"
  puts "Postorder: #{tree.post_order}"
  puts "Level order: #{tree.level_order}"
end
