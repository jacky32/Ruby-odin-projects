def bubble_sort(numbers)
  numbers.size.times do
    changed = false
    for i in 0..numbers.size
      if (numbers[i] <=> numbers[i+1]) == 1
        numbers[i], numbers[i+1] = numbers[i+1], numbers[i]
        changed = true
      end
    end
    break if changed == false
  end
  numbers
end
  
p bubble_sort([4,21,0,3,78,2,0,2])