def caesar_cipher(string, shift_factor)
  altered_string = string.split("").map do |symb|
    if ('a'..'z').to_a.include?(symb)
      symb_index = ('a'..'z').to_a.index(symb)
      #overflow compatibility
      if symb_index + shift_factor > 26
        overflow_index = symb_index + shift_factor - 26
        ('a'..'z').to_a[overflow_index]
      else
        ('a'..'z').to_a[symb_index+shift_factor]
      end
    elsif ('A'..'Z').to_a.include?(symb)
      symb_index = ('A'..'Z').to_a.index(symb)
      p symb_index
      #overflow compatibility
      if symb_index + shift_factor > 26
        overflow_index = symb_index + shift_factor - 26
        ('A'..'Z').to_a[overflow_index]
      else
        ('A'..'Z').to_a[symb_index+shift_factor]
      end
    else
      symb
    end
  end
  altered_string.join
end