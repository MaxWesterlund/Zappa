require 'socket'
require_relative 'router'
require_relative 'request'
require_relative 'response'

class HTTPServer
    attr_accessor :router

    # Initializes a new HTTP-server
    # 
    # @param port [Integer] The port that the server should be run on
    def initialize(port)
        @port = port
        @router = Router.new()
    end

    # Starts a new server and continiously checks if a route is matched
    #
    def start
        server = TCPServer.new(@port)
        puts "Listening on #{@port}" 

        while session = server.accept
            data = ""
            while line = session.gets and line !~ /^\s*$/
                data += line
            end
            puts "RECEIVED REQUEST"
            puts "-" * 40
            puts data
            puts "-" * 40 

            request = Request.new(data)
            if @router.route_exists?(request) || File.file?("./public/#{request.resource}")
                puts "MATCHED ROUTE: #{request.resource}"

                is_file = File.file?("./public/#{request.resource}")
                puts "IS FILE: #{is_file}"

                response = @router.run_route(request.resource, is_file)
                session.print response
                session.close
            else
                session.print "HTTP/1.1 404\r\nContent-Type: text/html\r\n\r\n<h1>Page not found!</h1>"
                session.close
                next
            end
        end
    end
end