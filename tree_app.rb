# frozen_string_literal: true

require_relative 'tree'

# Tests binary search tree
class TreeApp
  


  tree = Tree.new([0, 1, 2, 3, 4, 5, 6])
  # tree = Tree.new([3, 5, 4, 2, 7, 8, 9, 11, 15, 13, 12])
  tree.insert(4.5)
  tree.insert(1.5)
  # tree.delete(5)
  p tree.root
  # p tree.find(2)
  
  # p tree.level_order
  # tree.level_order { |data| puts data + 2 }

  # p tree.level_order_alt
  # tree.level_order_alt { |data| puts data + 2 }

  p tree.in_order


end
