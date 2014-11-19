module MerchantsGuide
  class Metric
    attr_reader :name, :original_value, :credits_value

    def initialize(name, original_value, credits_value)
      @name = name
      @original_value = original_value
      @credits_value = credits_value
    end

    def convert(value)
      credits_value * value / original_value
    end

    class << self
      def add(name, original_value, credits_value)
        units[name] = Metric.new(name, original_value, credits_value)
      end

      def convert(name, value)
        units[name].convert(value) if units.has_key?(name)
      end

      private

        def units
          @@units ||= {}
        end
    end
  end
end