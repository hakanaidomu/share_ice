require 'rails_helper'
describe UsersController, type: :request do
  before do
    @user = FactoryBot.create(:user)
  end

  describe '#show' do
    it 'showに遷移できる' do
      get user_path(@user)
      expect(response).to render_template :show
    end
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
      get user_path(@user)
      expect(response.status).to eq(200)
    end
    it 'showアクションにリクエストするとレスポンスにユーザーのnicknameが存在する' do
      get user_path(@user)
      expect(response.body).to include(@user.nickname)
    end
    it 'showアクションにリクエストするとレスポンスにユーザーのdescription存在する' do
      get user_path(@user)
      expect(response.body).to include(@user.description)
    end
    it 'showアクションにリクエストするとレスポンスにユーザーの直近1週間のデータ存在する' do
      get user_path(@user)
      expect(response.body).to include('直近1週間のデータ')
    end
    it 'showアクションにリクエストするとレスポンスにユーザーの直近1ヶ月のデータ存在する' do
      get user_path(@user)
      expect(response.body).to include('直近1ヶ月のデータ')
    end
  end
  describe '#edit' do
    context 'ログイン時' do
      it 'ログインしていたらeditに遷移できる' do
        sign_in(@user)
        get edit_user_registration_path(@user)
        expect(response).to render_template :edit
      end
      it 'ログインしていたらeditアクションにリクエストすると正常にレスポンスが返ってくる' do
        sign_in(@user)
        get edit_user_registration_path(@user)
        expect(response.status).to eq(200)
      end
    end
    context 'ログインしていないとき' do
      it 'ログインしていないと正常にレスポンスが帰って来ない' do
        get edit_user_registration_path(@user)
        expect(response.status).to eq(401)
      end
    end
  end
end
