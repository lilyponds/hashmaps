# Same as Hash Map but consists of only keys and no values.

require_relative './hash'

class HashSet
  def initialize
    puts 'An empty HashSet now exists.'
    @capacity = 16
    @buckets = Array.new(@capacity)
    @item_count = 0
    @load_factor = 0.75
  end

  def set(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    item = [key]
    if @buckets[index].nil?
      @buckets[index] = item
      @item_count += 1
    elsif @buckets[index].include?(key)
      puts "Your HashSet already has #{key}"
    else
      @buckets[index] << key
      @item_count += 1
    end
    p @buckets[index]
    increase_memory if @item_count > (@capacity * @load_factor)
    # puts @item_count.to_f / @capacity # - tested load factor using this
  end

  def has?(key)
    index = hash(key)
    if @buckets[index].nil?
      false
    elsif @buckets[index].include?(key)
      true
    else
      false
    end
  end

  def remove(key)
    return nil unless has?(key)

    index = hash(key)
    result = [key]
    @buckets[index].delete(key)
    @item_count -= 1
    result
  end

  def length
    @item_count
  end

  def clear
    initialize
  end

  def keys
    key_arr = []
    @buckets.each do |item|
      next if item.nil?

      item.each do |key|
        key_arr << key
      end
    end
    key_arr
  end

  private

  def increase_memory
    @item_count = 0
    @capacity *= 2
    temp_new = @buckets
    @buckets = Array.new(@capacity)
    temp_new.each do |item|
      item.each { |key| set(key) } unless item.nil?
    end
    puts "Memory was increased, the size is now #{@buckets.length}"
  end
end
