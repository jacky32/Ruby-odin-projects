# frozen_string_literal: true # rubocop:todo Naming/FileName

def stock_picker(stocks)
  final = [0, 0, 0]
  stocks.each_with_index do |stock, index|
    stocks.each_with_index do |compared_stock, compared_index|
      if final[0] < compared_stock - stock && index < compared_index
        final = [compared_stock - stock, index, compared_index]
      end
    end
  end
  final[1, 2]
end

p stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
