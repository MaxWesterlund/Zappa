require_relative 'lib/request'
require_relative 'lib/router'
require_relative 'lib/tcp_server'

server = HTTPServer.new(4567)

server.router.add_route("/") do |args|
    File.read("./views/index.html")
end

server.router.add_route("/test/:a/:b") do |args|
    "The first param is: #{args[0]}, and the second param is: #{args[1]}"
end

server.start()