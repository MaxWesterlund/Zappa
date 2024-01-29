require_relative 'spec_helper'
require_relative '../lib/router'

describe "Router" do
    it "generates simple responses" do
        router = Router.new
        response = router.generate_response("<p>test</p>")
        puts "Response:\n#{response}"
    end
end