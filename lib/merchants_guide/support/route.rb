module MerchantsGuide
  module Support
    class Route
      attr_accessor :regexp, :method

      def initialize(regexp, method)
        @regexp = regexp
        @method = method
      end

      def =~(text)
        regexp =~ text
      end

      def match(text)
        match_data = regexp.match(text)
        match_data.names.map{ |n| [n.to_sym, match_data[n]] }.to_h if match_data
      end
    end
  end
end