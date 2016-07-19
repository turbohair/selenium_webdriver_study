puts "Task 1. Create a method which will take a natural number as an argument and will find a sum of all its digits"
def sum_of_digits(number)
  digits_array = number.to_s.split('')
  digits_array.map! do |element|
    element.to_i
  end

  sum = 0
  digits_array.each do |i|
    sum += i
  end

  return sum
end

puts "Task 2. There is a string. Find a maximum number of digits placed in a row in it"

basic_string = 'The 1 string23 and 1234 and regular 243'
array_from_string = basic_string.split(' ')

array_of_numbers = array_from_string.map do |element|
  element.to_i.to_s
end

puts array_of_numbers.max_by(&:length).length

puts "Task 3. There is a string. Find a maximal number (not a digit) in it"
array_of_digits = array_from_string.map do |element|
  element.to_i
end

puts array_of_digits.max

puts "Task 4. There are two strings. Find number of first chars from first string matching first chars of the second string."
# strings are definitely different
# strings can completely match

string_a = 'string_avvv'
string_b = 'string_b'

array_a = string_a.split('')
array_b = string_b.split('')

array_result = Array.new
for i in 0..array_a.size
  if array_a[i] == array_b[i]
    array_result.push(array_a[i])
  else
    break
  end
end

puts array_result.size


puts "Task 5. There is an array of integers. First puts elements with even indexes and then with odd indexes"
array_of_integers = [6,2,4,4,7]
array_of_integers.each_with_index do |value,index|
  puts value if index.even?
end
array_of_integers.each_with_index do |value,index|
  puts value if index.odd?
end


puts "Task 6. There is an array of integers (ary). Puts the index of the last element where ary[0]<ary[i]<=ary[-1]"
ary = [2,4,25,43]
if ary[0] < ary.max && ary.max <= ary[-1]
  puts ary.max
  puts ary.index(ary.max)
else
  puts "Warning. Condition does not match."
end

puts "Task 7. There is an array of integers (ary). Modify it with adding ary[0] (first element of the array) to each even number. Don't do it for first and last elements"

ary_task7 = [2,2,2,2,2]

last_index = ary_task7.size - 1
first_element_value = ary_task7.first

ary2 = ary_task7.each_with_index do |value,index|
  if index.even? && (index != 0 && index != last_index)
    ary_task7[index] = value + first_element_value
  end
end
puts ary_task7
