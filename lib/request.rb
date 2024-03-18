# @author Max Westerlund
class Request
    attr_reader :method, :resource, :version, :headers, :params

    # Initializes a new request by dividing the method, resource, version, headers and params of a HTTP-request
    # 
    # @param request [String] The HTTP-request that should be divided as a string
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
end
