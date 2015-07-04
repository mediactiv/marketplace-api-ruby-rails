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

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @product_attributes = FactoryGirl.attributes_for :product
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, product: @product_attributes }
      end

      it "renders the json representation for the product record just created" do
        product_response = json_response
        expect(product_response[:title]).to eql @product_attributes[:title]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_product_attributes = { title: "Smart TV", price: "Twelve dollars" }
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, product: @invalid_product_attributes }
      end

      it "renders an errors json" do
        product_response = json_response
        expect(product_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        product_response = json_response
        expect(product_response[:errors][:price]).to include "is not a number"
      end

      it { should respond_with 422 }
    end
  end

<<<<<<< HEAD
  describe "PUT #update" do
    context 'when product is successfully updated' do
      before :each do
        @user = FactoryGirl.create :user
        @product = FactoryGirl.create :product,user:@user
        api_authorization_header @user.auth_token
        
      end
      it 'should respond with 200' do
        
      end
    end
  end

=======
>>>>>>> 2f441b99e2ad5f152fa7f9284eb8739d65aad222
end
