# frozen_string_literal: true

# Node class for binary search tree
class Node
  include Comparable

  attr_accessor :value, :left, :right
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  def <=>(other)
    @value <=> other.value
  end
end
