require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def get_bucket(key)
    num = key.hash
    bucket = num % num_buckets
    @store[bucket]
  end

  def include?(key)
    get_bucket(key).include?(key)
  end

  def set(key, val)
    self.count += 1 if !self.include?(key) 
    get_bucket(key).append(key, val)
    resize! if count > num_buckets
  end

  def get(key)
    get_bucket(key).get(key)
  end

  def delete(key)
    get_bucket(key).remove(key)
    self.count -= 1 
  end

  def each(&prc)
      @store.each do |bucket|
        bucket.each do |node|
          prc.call(node.key, node.val)
        end
      end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) {LinkedList.new}
    duplicate = @store
    @store = new_store
    @count = 0
    duplicate.each do |bucket|
      bucket.each do |node|
        self.set(node.key, node.val)
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
