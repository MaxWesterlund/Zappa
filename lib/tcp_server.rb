require 'socket'
require_relative 'router'
require_relative 'request'
require_relative 'response'

class HTTPServer

    def initialize(port)
        @port = port
    end

    def start
        server = TCPServer.new(@port)
        puts "Listening on #{@port}"
        router = Router.new

        router.add_route("/") do |args|
            File.read("./views/index.html")
        end

        router.add_route("/test/:a/:b") do |args|
            "The first param is: #{args[0]}, and the second param is: #{args[1]}"
        end

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
            if router.route_exists?(request) || File.file?("./public/#{request.resource}")
                puts "MATCHED ROUTE: #{request.resource}"

                is_file = File.file?("./public/#{request.resource}")
                puts "IS FILE: #{is_file}"

                response = router.run_route(request.resource, is_file)
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

server = HTTPServer.new(4567)
server.start