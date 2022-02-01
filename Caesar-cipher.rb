def caesar_cipher(string, shift_factor)
    altered_string = string.split("").map do |symb|
      symb unless ('a'..'z').to_a.include?(symb.downcase)
      symb if symb == " "
      if symb == symb.downcase
        symb_index = ('a'..'z').to_a.index(symb)
        p symb_index
        #overflow compatibility
        if symb_index + shift_factor > 26
          overflow_index = symb_index + shift_factor - 26
          ('a'..'z').to_a[overflow_index]
        else
          ('a'..'z').to_a[symb_index+shift_factor]
        end
      elsif symb == symb.upcase
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
  end
  
  caesar_cipher("What a string!", 5)