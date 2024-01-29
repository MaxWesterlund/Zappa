class RouteInfo
    attr_reader :expression
    attr_reader :block

    def initialize(expression, block)
        @expression = expression
        @block = block
    end
end