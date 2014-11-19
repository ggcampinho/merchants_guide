module MerchantsGuide
  module Support
    module Routable
      attr_accessor :params

      def exec_route(text)
        method = match_route(text)
        send(method) if method
      end

      def match_route(text)
        route = self.class.router.routes.detect { |r| r =~ text }
        if route
          self.params = route.match(text)
          route.method
        else
          self.params = {}
          self.class.router.not_found_route
        end
      end

      class << self
        def included(base)
          base.extend(ClassMethods)
        end
      end

      module ClassMethods
        def router
          @router ||= Router.new
        end

        private

          def add_route(regexp, method)
            router.routes << Route.new(regexp, method)
          end

          def add_not_found_route(method)
            router.not_found_route = method
          end
      end
    end
  end
end
