require_relative 'lib/request'
require_relative 'lib/router'

request = File.read("spec/example_requests/get-fruits-with-filter.request.txt")
parsed_request = Request.new(request)

puts "Method: #{parsed_request.method}"
puts "Resource: #{parsed_request.resource}"
puts "Version: #{parsed_request.version}"
puts "Headers: #{parsed_request.headers}"
puts "Params #{parsed_request.params}"