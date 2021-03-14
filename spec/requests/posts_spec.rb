require 'rails_helper'
describe PostsController, type: :request do
  before do
    @tweet = FactoryBot.create(:post)
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get root_path
      expect(response.status).to eq(200)
    end
  end
end
