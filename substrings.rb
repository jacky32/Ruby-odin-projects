# frozen_string_literal: true

def substrings(string, dictionary)
  string_array = string.downcase.split(' ')
  result = {}
  dictionary.each do |d_word|
    string_array.each do |s_word|
      if s_word.include?(d_word)
        result[d_word].nil? ? result[d_word] = 1 : result[d_word] += 1
      end
    end
  end
  result
end

dictionary = %w[below down go going horn how howdy it i low own part partner sit]

p substrings('below', dictionary)
p substrings("Howdy partner, sit down! How's it going?", dictionary)
