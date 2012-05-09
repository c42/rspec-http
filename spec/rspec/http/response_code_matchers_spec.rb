require "spec_helper"

module RSpec::Http
  describe ResponseCodeMatchers do
    include ResponseCodeMatchers

    context 'status to matcher conversion' do
      it "replaces spaces with underscores" do
        StatusCodes.clean_up_status("Method Not Allowed").should eq(:method_not_allowed)
      end

      it "downcases capital letters" do
        StatusCodes.clean_up_status("IM Used").should eq(:im_used)
      end

      it "removes apostrophes" do
        StatusCodes.clean_up_status("I'm A Teapot").should eq(:im_a_teapot)
      end

      it "replaces hyphens with underscores" do
        StatusCodes.clean_up_status("Non-Authoritative Information").should eq(:non_authoritative_information)
      end
    end

    context "matching codes" do
      StatusCodes.values.each do |code, status|
        it "understands if a response is of type #{status}" do
          response = Rack::MockResponse.new(code, {}, "")
          response.should send("be_http_#{StatusCodes.as_valid_method_name(code)}")
        end

        it "understands if a response is not of type #{status}" do
          response = Rack::MockResponse.new(0, {}, "")
          response.should_not send("be_http_#{StatusCodes.as_valid_method_name(code)}")
        end
      end

      context "where the value of the location header field can be important" do
        it "response of type created" do
          response = Rack::MockResponse.new(201, {"Location" => "http://test.server"}, "")
          expect{ response.should be_http_ok }.to raise_error(/with a location of http:\/\/test\.server$/)
        end

        it "response of type redirect" do
          response = Rack::MockResponse.new(302, {"Location" => "http://test.server"}, "")
          expect{ response.should be_http_ok }.to raise_error(/with a location of http:\/\/test\.server$/)
        end
      end
    end
  end
end
