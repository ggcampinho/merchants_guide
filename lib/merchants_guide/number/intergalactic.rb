module MerchantsGuide
  module Number
    class Intergalactic
      attr_reader :digits

      def initialize(number)
        @digits = number.split
        raise MerchantsGuide::Error::Number::Invalid, number if digits.any? { |d| !Intergalactic.symbols.has_key?(d) }
      end

      def to_roman
        Roman.new(@digits.map{ |d| Intergalactic.symbols[d] }.join)
      end

      def to_i
        to_roman.to_i
      end

      def to_s
        digits.join(' ')
      end

      class << self
        def symbols
          @@symbols ||= {}
        end

        def add_symbol(symbol, roman_symbol)
          symbols[symbol] = roman_symbol if Roman::SYMBOLS.include?(roman_symbol)
        end
      end
    end
  end
end