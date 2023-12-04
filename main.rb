require_relative 'lib/request'
require_relative 'lib/router'

router = Router.new

router.add_route("/hej")
p router.match_route("/hej")
p router.match_route("/nej")