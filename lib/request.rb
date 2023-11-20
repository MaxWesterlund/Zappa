class Request
    attr_reader :method
    attr_reader :resource
    attr_reader :version
    attr_reader :headers
    attr_reader :params
    
    def initialize (request)
        request_lines = request.split("\n")
        request_lines.reject! { |i| i.empty? }
        info = request_lines[0]

        @method, @resource, @version = request_lines[0].split(" ")

        header_lines = request_lines[1..request_lines.length - 1]
        if header_lines.last[0] == header_lines.last[0].downcase
            header_lines.pop
        end

        @headers = Hash.new()
        header_lines.each do |line|
            key, value = line.split(": ", 2)
            @headers.store(key, value)
        end

        @params = Hash.new()
        param_source = @method == "GET" ? @resource.split("?", 2).last : request_lines.last
        param_lines = param_source.split("&")
        param_lines.each do |line|
            key, value = line.split("=", 2)
            @params.store(key, value)
        end

        @method = "nej"
    end
end