require_relative 'route_info'

# @author Max Westerlund
class Router
    def initialize
        @routes = []
    end

    # Checks if a route is added
    #
    # @param request [Request] The request containing the route
    # @return [Boolean] If the route exists or not
    def route_exists?(request)
        resource = request.resource
        @routes.each do |route|
            puts route.expression
            if route.expression.match(resource)
                return true
            end
        end
        return false
    end

    # Adds a route so that it can be found by the server
    #
    # @param route [String] The route that should be added
    def add_route(route, &block)
        expression = generate_regular_route(route)
        info = RouteInfo.new(route, expression, block)
        @routes << info
    end

    # Finds the route block and creates a HTTP-response
    #
    # @param route [String] The route that should be run
    # @param is_file [Boolean] Determines if a file should be read or not
    # @return [String] A corresponding HTTP-response
    def run_route(route, is_file)
        if is_file
            file_format = route.match(/\w+\z/)
            content = File.read("./public/#{route}", mode: get_read_type(file_format))
            response = generate_response(content, file_format)
            return response
        else
            info = find_route_info(route)
            if info == nil
                return puts("Route not found")
            end
            args = info.expression.match(route)[1..-1]
            content = info.block.call(args)
            response = generate_response(content, "html")
            return response
        end
    end

    private def find_route_info(route)
        @routes.each do |info|
            if route.match(info.expression)
                return info
            end
        end
        return nil
    end

    private def generate_regular_route(route)
        exp = Regexp.new(route.gsub(/:(\w+)/, "(\\w+)") + "$")
        return exp
    end

    private def get_read_type(file_format)
        case file_format
        when "html" 
            return "r"
        when "css"
            return "r"
        else
            return "rb"
        end
    end

    private def generate_response(content, file_format)
        response = ""
        response += "HTTP/1.1 200\r\n"
        response += "Content-Type: #{get_content_type(file_format)}\r\n"
        response += "Content-Length: #{content.length()}\r\n"
        response += "\r\n"
        response += content
        return response 
    end

    private def get_content_type(file_format)
        case file_format
        when "html"
            return "text/html"
        when "css"
            return "text/css"
        when "jpg" || "jpeg"
            return "image/jpeg"
        end
    end
end