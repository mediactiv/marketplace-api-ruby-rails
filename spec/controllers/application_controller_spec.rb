require 'rails_helper'
require 'spec_helper'

describe ApplicationController do
  describe "Get #index" do
    before(:each) do
      get :index
    end
    it "returns a plain text response" do
      expect(response.body).to eql 'Market Place API!'
    end
  end
end