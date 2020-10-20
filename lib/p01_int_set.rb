class MaxIntSet
  attr_reader :store
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    if is_valid?(num)
      self.store[num] = true 
    else
      validate!(num)
    end
  end

  def remove(num)
    self.store[num] = false
  end

  def include?(num)
    # if self.insert(num)
    #   return true
    # else
    #   return false 
    # end
    @store[num] 
  end

  private

  def is_valid?(num)
    num.between?(0, self.store.length - 1)
  end

  def validate!(num)
    raise "Out of bounds" if !is_valid?(num)
  end
end


class IntSet
  attr_reader :store 
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    return false if self.include?(num) 
    i = num % 20
    @store[i].push(num) 
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
    end
  end

  def include?(num)
    # i = num % 20 
    @store[num % 20].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    i = num % 20 
    @store[i]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return false if self.include?(num)
    i = num % 20
    @store[i].push(num)
    self.count += 1 
    resize! if count > num_buckets
  end

  def remove(num)
    if self.include?(num) 
      self.store[num % 20].delete(num) 
      self.count -= 1
    end
  end

  def include?(num)
    i = self.store[num % 20]
    i.include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    previous = self.store
    self.count = 0 
    self.store = Array.new(previous.length * 2) {Array.new}
    previous.flatten.each { |ele| insert(ele) } 
   
  end
end
