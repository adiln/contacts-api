require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "login and registration" do
    context "requires registration" do
      it "requires registration" do
        expect { post :register, params:   FactoryBot.attributes_for(:user) }.to change(User, :count).by(1)
      end
    end
    context "requires login" do
      before do
        User.create!(FactoryBot.attributes_for(:user))
      end
      it "requires login" do
        post :login, params: { username: 'abc@gmail.com', password: 'Abcd123#' }
        expect(response).to be_success
      end
    end
  end

end
