require 'route_info'

class Router
    VERSION = "HTTP 1.1"

    def initialize
        @routes = []
    end

    def add_route(route, &block)
        expression = generate_regular_route(route)
        info = RouteInfo.new(expression, block)
        @routes << info
    end

    def run_route(route)
        info = find_route_info(route)
        if info == nil
            return puts("Route not found")
        end

        args = info.expression.match(route)[1..-1]

        info.block.call(args)
    end

    def generate_response(content)
        status = "200 OK"
        response = "#{VERSION} #{status}\n"
        response += "Content-Length: #{content.to_s.length}\n"
        response += "\n#{content}"
        return response
    end

    private def find_route_info(route)
        @routes.each do |info|
            if !!(info.expression =~ route)
                return info
            end
        end
        return nil
    end

    private def generate_regular_route(route)
        exp = Regexp.new(route.gsub(/:(\w+)/, "(\\w+)"))
        return exp
    end
end