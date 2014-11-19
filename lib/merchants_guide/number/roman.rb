module MerchantsGuide
  module Number
    class Roman
      SYMBOLS = %w(I V X L C D M)
      ARABIC_CONVERSION = { 'I' => 1, 'V' => 5, 'X' => 10, 'L' => 50, 'C' => 100, 'D' => 500, 'M' => 1000 }

      attr_reader :digits

      def initialize(number)
        @digits = number.chars
      end

      def ==(obj)
        obj.respond_to?(:to_roman) && digits == obj.to_roman.digits
      end

      def to_roman
        self
      end

      def to_i
        memo = digits.inject({ sum: 0, last: nil }) do |memo, digit|
          memo[:sum] += ARABIC_CONVERSION[digit]
          memo[:sum] -= 2 * ARABIC_CONVERSION[memo[:last]] if memo[:last] != nil && SYMBOLS.index(digit) > SYMBOLS.index(memo[:last])
          memo[:last] = digit
          memo
        end
        memo[:sum]
      end
    end
  end
end