module MerchantsGuide
  module Support
    class Router
      attr_accessor :not_found_route

      def routes
        @routes ||= []
      end

      def clean
        @routes = []
        @not_found_route = nil
      end
    end
  end
end
