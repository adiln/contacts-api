require 'rails_helper'

RSpec.describe Api::V1::GroupsController, type: :controller do
  let!(:user) { FactoryBot.create(:user, FactoryBot.attributes_for(:user)) }
  let!(:group) { FactoryBot.create(:group, user_id: user.id, name: "group 1", active: true) }

  describe 'GET "Index"' do
    it 'returns a group' do
      get :index, params: { user_id: user.id }
      expect(response).to be_success
    end
  end
end
