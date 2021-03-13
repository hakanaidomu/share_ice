require 'rails_helper'

RSpec.describe '新規投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.build(:post)
  end

  context '新規投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      sign_in(@user)
      first(:link, '新規投稿').click
      expect(current_path).to eq new_post_path
      fill_in 'post_content', with: @post.content
      attach_file 'post[image]', 'app/assets/images/default_image.jpg'
      click_button '投稿する'
      expect(current_path).to eq root_path
      expect(page).to have_content(@post.content)
    end
  end

  context '新規投稿ができないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      visit root_path
      expect(page).to have_no_content('新規投稿')
    end

    it 'contentが空だと投稿できない' do
      sign_in(@user)
      first(:link, '新規投稿').click
      expect(current_path).to eq new_post_path
      fill_in 'post_content', with: ''
      attach_file 'post[image]', 'app/assets/images/default_image.jpg'
      click_button '投稿する'
      expect(current_path).to eq '/posts'
    end

    it 'imageが空だと投稿できない' do
      sign_in(@user)
      first(:link, '新規投稿').click
      expect(current_path).to eq new_post_path
      fill_in 'post_content', with: @post.content
      click_button '投稿する'
      expect(current_path).to eq '/posts'
    end
  end
end

RSpec.describe '投稿内容の編集', type: :system do
  before do
    @post = FactoryBot.create(:post)
  end
  context '投稿内容が編集できるとき' do
    it 'ログインしたユーザーは、自分が投稿した投稿内容を編集ができる' do
      sign_in(@post.user)
      first(:link, '詳細ページへ').click
      first(:link, '編集').click
      expect(current_path).to eq edit_post_path(@post)
    end
  end
end
