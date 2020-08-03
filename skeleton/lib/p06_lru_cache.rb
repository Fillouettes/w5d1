require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if !@map.include?(key)
      calc!(key) 
    else   #update this key as most recent, reorder the rest
      update_node!(@map[key])
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    value = @prc.call(key)
    new_node = @store.append(key, value)
    @map[key] = new_node
    eject! if @map.count > @max
    return value
  end

  def update_node!(node)
    k = node.key
    v = node.val
    node.remove
    new_node = @store.append(k, v)
    @map[k] = new_node
  end
  
def eject!
    @map.delete(@store.first.key)
    @store.other_remove(0)
  end
end