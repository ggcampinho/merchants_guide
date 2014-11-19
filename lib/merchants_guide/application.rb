module MerchantsGuide
  class Application
    include MerchantsGuide::Support::Routable

    add_route /\Ahow many Credits is (?<phrase>.+) (?<metric>\S+) \?\z/, :convert_metric
    add_route /\Ahow much is (?<phrase>.+) \?\z/, :convert_unit
    add_route /\A(?<phrase>.+) (?<metric>\S+) is (?<value>\d+) Credits\z/, :define_metric
    add_route /\A(?<word>\S+) is (?<value>\S+)\z/, :define_unit
    add_not_found_route :no_idea

    def start
      $stdin.each_line { |line| exec_route(line.chomp) }
    end

    def convert_unit
      n = intergalatic_number
      puts "#{n} is #{n.to_i}"
    rescue MerchantsGuide::Error::Number::Invalid
      no_idea
    end

    def convert_metric
      converted = Metric.convert(params[:metric], intergalatic_number.to_i)
      puts "#{params[:phrase]} #{params[:metric]} is #{converted} Credits"
    rescue MerchantsGuide::Error::Number::Invalid
      no_idea
    end

    def define_unit
      Number::Intergalactic.add_symbol(params[:word], params[:value])
    end

    def define_metric
      Metric.add(params[:metric], intergalatic_number.to_i, params[:value].to_i)
    end

    def intergalatic_number
      Number::Intergalactic.new(params[:phrase])
    end

    def no_idea
      puts "I have no idea what you are talking about"
    end
  end
end
