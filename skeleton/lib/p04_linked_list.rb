
class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @next.prev = self.prev 
    @prev.next = self.next  
  end

  def inspect
    key
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next 
  end

  def last
    @tail.prev 
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each {|node| return node.val if node.key == key}
  end

  def get_index(key)
    i = 0 
    self.each do |node|
      return i if node.key == key 
      i += 1 
    end
    nil 
  end

  def include?(key)
    i = get(key)
    i != nil 
  end

  def append(key, val)
    if self.include?(key)
      self.update(key, val)
    else 
      node = Node.new(key, val)
      node.prev = @tail.prev 
      node.next = @tail 
      @tail.prev = node 
      node.prev.next = node 
    end
    return node
  end

  def update(key, val)
    i = get_index(key)
    self[i].val = val if i
  end

  def remove(key)
    i = get_index(key)
    self[i].remove
  end

   def other_remove(i)
    self[i].remove 
  end

  def each(&prc)
    node = @head.next 
    until node == @tail
      prc.call(node) 
      node = node.next 
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end