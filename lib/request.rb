class Request
    attr_reader :method, :resource, :version, :headers, :params
    
    def initialize (request)
        request_lines = request.split("\n")
        request_lines.reject! { |i| i.empty? }

        @method, @resource, @version = parse_basic_info(request_lines)

        @headers = parse_headers(request_lines)
        
        @params = parse_params(request_lines)
    end

    private def parse_basic_info(request_lines)
        return request_lines[0].split(" ")
    end

    private def parse_headers(request_lines)
        header_lines = request_lines[1..request_lines.length - 1]
        if header_lines.last[0] == header_lines.last[0].downcase
            header_lines.pop
        end

        headers = Hash.new()
        header_lines.each do |line|
            key, value = line.split(": ", 2)
            headers.store(key, value)
        end

        return headers
    end

    private def parse_params(request_lines)
        params = Hash.new()
        param_source = @method == "GET" ? @resource.split("?", 2).last : request_lines.last
        param_lines = param_source.split("&")
        param_lines.each do |line|
            key, value = line.split("=", 2)
            params.store(key, value)
        end

        return params
    end
end
