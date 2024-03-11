class RouteInfo
    attr_reader :route
    attr_reader :expression
    attr_reader :block

    def initialize(route, expression, block)
        @route = route
        @expression = expression
        @block = block
    end
end