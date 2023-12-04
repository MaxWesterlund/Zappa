require_relative 'spec_helper'
require_relative '../lib/router'

describe "Router" do
    it "stores simple static routes and compares correctly" do
        router = Router.new
        router.add_route("/a")
        _(router.match_route("/a")).must_equal true
        _(router.match_route("/b")).must_equal false
    end

    it "stores simple dynamic routes and compares correctly" do
        router = Router.new
        router.add_route("/a/:i")
        _(router.match_route("/a/1")).must_equal true
        _(router.match_route("/a/b")).must_equal true
        _(router.match_route("/a")).must_equal false
        
    end

    it "stores complex dynamic routes and compares correctly" do
        router = Router.new
        router.add_route("/a/:i/b/c/:j/e")
        _(router.match_route("/a/1/b/c/2/e")).must_equal true
        _(router.match_route("/a/f/b/c/g/e")).must_equal true
        _(router.match_route("/a/b/c/e")).must_equal false   
    end
end
