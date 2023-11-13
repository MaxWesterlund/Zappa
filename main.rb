require_relative 'request'

s = File.read('Example Requests/post-login.request.txt')
request = Request.new(s)

p request.method
p request.resource
p request.version
p request.headers
p request.params