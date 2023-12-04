class Router
    def initialize
        @routes = []
    end

    def add_route(route)
        exp = generate_regular_route(route)
        if !@routes.include?(exp)
            @routes << exp
        end
    end

    def match_route(route)
        @routes.each do |r|
            if !!(route =~ r)
                return true
            end
        end
        return false
    end

    private def generate_regular_route(route)
        exp = Regexp.new(route.gsub(/:(\w+)/, "(\\w+)"))
        return exp
    end
end