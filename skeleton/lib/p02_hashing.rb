class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    int = 0
    self.each_with_index do |ele, i|
      int += ele * i
    end
    return int
  end
end

class String
  def hash
    int = 0 
    self.split("").each_with_index do |char, i|
      int += char.codepoints[0] * (i + 1)  
    end
    int 
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    int = 0 
    self.each do |k, v|
      int += k.hash + v.hash 
    end
    int 
  end
end
