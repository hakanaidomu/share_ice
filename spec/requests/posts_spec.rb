require 'rails_helper'
describe PostsController, type: :request do

  before do
    @post = FactoryBot.create(:post)
    @user = FactoryBot.create(:user)
  end

  describe'GET #index' do
    it "indexに遷移できる" do
      get posts_path
      expect(response).to render_template :index
    end
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get root_path
      expect(response.status).to eq(200)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みpostのcontentが存在する' do 
      get root_path
      expect(response.body).to include(@post.content)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのpostのimageが存在する' do 
      get root_path
      expect(response.body).to include("card-img-top")
    end
  end
  describe '#show' do
    it "showに遷移できる" do
      get post_path(@post)
      expect(response).to render_template :show
    end
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get post_path(@post)
      expect(response.status).to eq(200)
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みpostのcontentが存在する' do 
      get post_path(@post)
      expect(response.body).to include(@post.content)
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みのpostのimageが存在する' do 
      get post_path(@post)
      expect(response.body).to include("post_image")
    end
    it 'showアクションにリクエストするとレスポンスにコメント表示部分が存在する' do 
      get post_path(@post)
      expect(response.body).to include("コメント")
    end
  end
  describe 'GET #new' do
    context 'ログイン時' do
      it 'ログインしていたらnewに遷移できる' do
        sign_in(@user)
        get new_post_path
        expect(response).to render_template :new
      end
      it 'ログイン時にnewアクションにリクエストすると正常にレスポンスが返ってくる' do 
        sign_in(@user)
        get new_post_path
        expect(response.status).to eq(200)
      end
    end
    context 'ログインしていないとき' do
      it 'ログインしていないとログイン画面に遷移する' do
        get new_post_path
        expect(response).to redirect_to(new_user_session_path)
      end
      it 'リクエストは302であること' do
        get new_post_path
        expect(response.status).to eq 302
      end
    end
  end
  describe 'GET #edit' do
    context 'ログイン時' do
      it 'ログインしていたらeditに遷移できる' do
        sign_in(@post.user)
        get edit_post_path(@post)
        expect(response).to render_template :edit
      end
      it 'ログイン時にeditアクションにリクエストすると正常にレスポンスが返ってくる' do 
        sign_in(@post.user)
        get edit_post_path(@post)
        expect(response.status).to eq(200)
      end
    end
    context 'ログインしていないとき' do
      it 'ログインしていないとログイン画面に遷移する' do
        get edit_post_path(@post)
        expect(response).to redirect_to(new_user_session_path)
      end
      it 'リクエストは302であること' do
        get edit_post_path(@post)
        expect(response.status).to eq 302
      end
    end
    context '他のユーザーの場合' do
      it '他のユーザーの場合トップページに遷移する' do
        sign_in(@user)
        get edit_post_path(@post)
        expect(response).to redirect_to(root_path)
      end

      it 'リクエストは302であること' do
        sign_in(@user)
        get edit_post_path(@post)
        expect(response.status).to eq 302
      end
    end
  end
  describe 'GET #destroy' do
    context 'ログイン時' do
      it 'ログインユーザーと投稿ユーザーが同じなら削除できる' do
        sign_in(@post.user)
        expect { delete post_path(@post) }.to change(Post, :count).by(-1)
        expect(response).to redirect_to(root_path)
      end
    end
    context 'ログインしていないとき' do
      it '削除できずにログイン画面に遷移する' do
        expect { delete post_path(@post) }.to change(Post, :count).by(0)
        expect(response).to redirect_to(new_user_session_path)
      end
      it 'リクエストは302であること' do
        expect { delete post_path(@post) }.to change(Post, :count).by(0)
        expect(response.status).to eq 302
      end
    end
    context '他のユーザーの場合' do
      it '削除できずにトップページに遷移する' do
        sign_in(@user)
        expect { delete post_path(@post) }.to change(Post, :count).by(0)
        expect(response).to redirect_to(root_path)
      end

      it 'リクエストは302であること' do
        sign_in(@user)
        expect { delete post_path(@post) }.to change(Post, :count).by(0)
        expect(response.status).to eq 302
      end
    end
  end
end
