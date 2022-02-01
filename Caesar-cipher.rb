def caesar_cipher(string, shift_factor)
  altered_string = string.split("").map do |symb|
    if ('a'..'z').to_a.include?(symb) #checks whether symbol is UPPER/lower or not a letter
      symb_index = ('a'..'z').to_a.index(symb) 
      overflow_index = symb_index + shift_factor
      overflow_index -= 26 while overflow_index > 25 #overflow compatibility
      ('a'..'z').to_a[overflow_index] #returns transformed letter
    elsif ('A'..'Z').to_a.include?(symb)
      symb_index = ('A'..'Z').to_a.index(symb)
      overflow_index = symb_index + shift_factor
      overflow_index -= 26 while overflow_index > 25
      ('A'..'Z').to_a[overflow_index]
    else
      symb
    end
  end
  altered_string.join
end