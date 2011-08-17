require 'spec_helper'

module RSpec::Http
  describe HeaderMatchers do
    include HeaderMatchers
    let(:response) { Rack::Response.new }
    before(:each) { response["Content-Type"] = "text/plain"}
  
    context "checking for the presence of a header" do
      it "passes if the header is set" do
        response.should have_header('Content-Type')
      end
      
      it "fails if the header is not set" do
        response.should_not have_header('Foobar')
      end
    end
    
    context "checking the value of the header" do
      it "passes if the value is set correctly" do
        response.should have_header("Content-Type" => "text/plain")
      end
      
      it "fails if the value is incorrect" do
        response.should_not have_header("Content-Type" => "text/csv")
      end
      
      it "fails if the header is missing" do
        response.should_not have_header("Foobar" => "text/csv")
      end
    end
    
    context "comparing the value to a regex" do
      it "passes if the value is set correctly" do
        response.should have_header("Content-Type" => /plain/)
      end
      
      it "fails if the value is incorrect" do
        response.should_not have_header("Content-Type" => /csv/)
      end
      
      it "fails if the header is missing" do
        response.should_not have_header("Foobar" => /csv/)
      end
    end
  end
end