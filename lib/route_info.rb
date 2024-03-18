# @author Max Westerlund
class RouteInfo
    attr_reader :route
    attr_reader :expression
    attr_reader :block

    # Initializes a new instance of route info
    #
    # @param route [String] The route that the info belongs to
    # @param expression [Regex] A regular expression that describes the route
    # @param block [Block] The route block
    def initialize(route, expression, block)
        @route = route
        @expression = expression
        @block = block
    end
end