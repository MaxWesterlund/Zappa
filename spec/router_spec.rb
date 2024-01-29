require_relative 'spec_helper'
require_relative '../lib/router'

describe "Router" do
    it "stores and runs simple static routes" do
        router = Router.new
        route = "/a"
        router.add_route(route) do
            return 42
        end
        _(router.run_route(route)).must_equal(42)
    end

    it "stores and runs simple dynamic routes" do
        router = Router.new
        route = "/a/:b"
        router.add_route(route) do |args|
            return args[0]
        end
        content = router.run_route("/a/42")
        puts router.generate_response(content)
        _(content).must_equal(42)
    end

    it "stores and runs complex dynamic routes" do
        router = Router.new
        route = "/a/:b/c/:d"
        router.add_route(route) do |args|
            return args[0] + args[1]
        end
        _(router.run_route("/a/42/c/1")).must_equal(43)
    end
end
