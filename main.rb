require './lib/hashmap'

test = HashMap.new
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')
test.set('moon', 'silver')
test.set('dog', 'black')

puts test.set('cat', 'orange')
puts test.get('car')
puts test.get('cat')
puts test.remove('cat')
puts test.has?('lion')
p test.keys
puts '-------------------'
p test.values
puts '-------------------'
p test.entries
puts '-------------------'
test.clear
puts test.length
puts '-------------------'
puts test.set('cat', 'orange')
puts test.length
puts '-------------------'
