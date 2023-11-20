require_relative 'spec_helper'
require_relative '../lib/request'

describe "Request" do
    describe "Simple get-request" do
        it "parses the http verb" do
            request_1 = Request.new(File.read("./spec/example_requests/get-examples.request.txt"))
            _(request_1.method).must_equal "GET"
            request_2 = Request.new(File.read("./spec/example_requests/post-login.request.txt"))
            _(request_2.method).must_equal "POST"
        end

        it "parses the resource" do
            request_1 = Request.new(File.read("./spec/example_requests/get-examples.request.txt"))
            _(request_1.resource).must_equal "/examples"
            request_2 = Request.new(File.read("./spec/example_requests/get-fruits-with-filter.request.txt"))
            _(request_2.resource).must_equal "/fruits?type=bananas&minrating=4"
        end

        it "parses the version" do
            request = Request.new(File.read("./spec/example_requests/get-examples.request.txt"))
            _(request.version).must_equal "HTTP/1.1"
        end

        it "parses the headers" do
            request = Request.new(File.read("./spec/example_requests/get-examples.request.txt"))
            _(request.headers).must_equal Hash["Host" => "example.com", "User-Agent" => "ExampleBrowser/1.0", "Accept-Encoding" => "gzip, deflate", "Accept" => "*/*"]
        end

        it "parses the params" do
            request_1 = Request.new(File.read("./spec/example_requests/get-fruits-with-filter.request.txt"))
            _(request_1.params).must_equal Hash["type" => "bananas", "minrating" => "4"]
            request_2 = Request.new(File.read("./spec/example_requests/post-login.request.txt"))
            _(request_2.params).must_equal Hash["username" => "grillkorv", "password" => "verys3cret!"]
        end
    end
end