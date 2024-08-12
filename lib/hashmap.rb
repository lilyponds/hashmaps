require_relative './hash'

class HashMap
  def initialize
    puts 'An empty Hash now exists.'
    @capacity = 16
    @buckets = Array.new(@capacity)
    @item_count = 0
    @load_factor = 0.75
  end

  def set(key, value)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    item = {}
    item[key] = value
    if @buckets[index].nil?
      @buckets[index] = item
      @item_count += 1
    elsif @buckets[index].key?(key)
      puts "Value for #{key} was updated from #{@buckets[index][key]} to #{value}"
      @buckets[index][key] = value
    else
      @buckets[index].merge! item
      @item_count += 1
    end
    puts @buckets[index]
    increase_memory if @item_count > (@capacity * @load_factor)
    # puts @item_count.to_f / @capacity # - tested load factor using this
  end

  def get(key)
    index = hash(key)
    if @buckets[index].nil?
      "Key #{key} does not exist."
    elsif @buckets[index].key?(key)
      @buckets[index][key]
    else
      "Key #{key} does not exist."
    end
  end

  def has?(key)
    index = hash(key)
    if @buckets[index].nil?
      false
    elsif @buckets[index].key?(key)
      true
    else
      false
    end
  end

  def remove(key)
    return nil unless has?(key)

    index = hash(key)
    result = [key, @buckets[index][key]]
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

      item.each_key do |key|
        key_arr << key
      end
    end
    key_arr
  end

  def values
    values_arr = []
    @buckets.each do |item|
      next if item.nil?

      item.each_value do |value|
        values_arr << value
      end
    end
    values_arr
  end

  def entries
    entries_arr = []
    @buckets.each do |item|
      next if item.nil?

      item.each do |key, value|
        entries_arr << [key, value]
      end
    end
    entries_arr
  end

  private

  def increase_memory
    @item_count = 0
    @capacity *= 2
    temp_new = @buckets
    @buckets = Array.new(@capacity)
    temp_new.each do |item|
      item.each { |key, value| set(key, value) } unless item.nil?
    end
    puts "Memory was increased, the size is now #{@buckets.length}"
  end
end
