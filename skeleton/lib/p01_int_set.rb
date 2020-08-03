class MaxIntSet
  attr_accessor :store
  
  def initialize(max)
    @max = max 
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" if !(0...max).include?(num)
    store[num] = true 
  end

  def remove(num)
    raise "Out of bounds" if !(0...max).include?(num)
    store[num] = false  
  end

  def include?(num)
    store[num]
  end

  private

  attr_reader :max 
  
  # def is_valid?(num)
  #   (0...max).include?(num)
  # end

  # def validate!(num)
  #   until store.length == num 
  #     store << nil 
  #   end
  #   @max = num 
  # end
end


class IntSet 
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = num % 20
    @store[bucket] << num
  end

  def remove(num)
    bucket = num % 20
    @store[bucket].delete(num)   
  end

  def include?(num)
    bucket = num % num_buckets
    @store[bucket].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
  return false if include?(num) 
    bucket = num % num_buckets
    @store[bucket] << num
    @count += 1
    resize! if @count > num_buckets
  end

  def remove(num)
     return false if !include?(num)
    bucket = num % num_buckets
    @store[bucket].delete(num) 
    @count -= 1  
  end

  def include?(num)
    bucket = num % num_buckets
    @store[bucket].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
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
