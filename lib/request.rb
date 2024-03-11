class Request
    attr_reader :method, :resource, :version, :headers, :params
    
    def initialize (request)
        @method, @resource, @version = request.scan(/(\A\w+) (\/.*) (HTTP\/.+)/).first

        @headers = Hash.new()

        header_keys = request.scan(/(.+): /)
        header_values = request.scan(/: (.+)/)

        if !header_keys.nil?
            for i in 0..header_keys.length - 1
                @headers.store(header_keys[i].first, header_values[i].first) 
            end
        end

        @params = Hash.new()

        param_keys = request.scan(/[[?]|&](\w+)=/)
        param_values = request.scan(/=(\w+)/)

        if param_keys.length > 0
            for i in 0..param_keys.length - 1
                @params.store(param_keys[i].first, param_values[i].first)
            end
        end
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

    private def parse_params(request)
        lines = request.split("\n")
        params = Hash.new()
        param_source = @method == "GET" ? @resource.split("?", 2).last : lines.last
        param_lines = param_source.split("&")
        param_lines.each do |line|
            key, value = line.split("=", 2)
            params.store(key, value)
        end

        return params
    end
end
