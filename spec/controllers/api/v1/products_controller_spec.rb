require 'rails_helper'
require 'spec_helper'
describe Api::V1::ProductsController  do

  describe "GET #index" do
    before :each do
      4.times{FactoryGirl.create :product}
      get :index
    end
    it 'returns 4 records from db' do
      product_response=json_response
      product_response[:products].count.should eq 4
    end
    it {should respond_with 200}
  end

  describe "GET #show" do
    before :each do
      @product = FactoryGirl.create :product
      get :show, id: @product.id
    end
    it "returns http success" do
      product_reponse = json_response
      expect(product_reponse[:title]).to eql @product.title#have_http_status(:success)
    end
    it {should respond_with 200 }
  end

end
