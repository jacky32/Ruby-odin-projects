# frozen_string_literal: true # rubocop:todo Naming/FileName

def bubble_sort(numbers) # rubocop:todo Metrics/MethodLength
  numbers.size.times do
    changed = false
    (0..numbers.size).each do |i|
      if (numbers[i] <=> numbers[i + 1]) == 1
        numbers[i], numbers[i + 1] = numbers[i + 1], numbers[i]
        changed = true
      end
    end
    break if changed == false
  end
  numbers
end

p bubble_sort([4, 21, 0, 3, 78, 2, 0, 2])
