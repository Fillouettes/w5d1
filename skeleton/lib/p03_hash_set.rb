class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key.hash 
    return false if include?(key) 
    self[num] << key 
    @count += 1
    resize! if @count > num_buckets
  end

  def include?(key)
    num = key.hash
    self[num].include?(key)
  end

  def remove(key)
    return false if !include?(key)
    num = key.hash 
    self[num].delete(key)
    @count -= 1  
  end

  private

  def [](num)
    bucket = num % num_buckets
    @store[bucket]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) {Array.new}
    duplicate = @store
    @store = new_store
    @count = 0
    duplicate.each do |bucket|
      bucket.each do |ele|
        self.insert(ele)
      end
    end
  end
end