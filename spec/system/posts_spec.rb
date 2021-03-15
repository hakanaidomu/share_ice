require 'rails_helper'

RSpec.describe '新規投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
  end
  context '新規投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      sign_in(@user)
      first(:link, '新規投稿').click
      expect(current_path).to eq new_post_path
      fill_in 'post_content', with: @post.content
      attach_file 'post[image]', 'app/assets/images/default_image.jpg'
      click_button '投稿する'
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

RSpec.describe '投稿内容の詳細', type: :system do
  before do
    @post = FactoryBot.create(:post)
  end
  context '投稿内容が正しく表示されるとき' do
    it 'contentが表示される' do
      visit root_path
      visit post_path(@post)
      expect(page).to have_content(@post.content)
    end
    it 'priceが表示される' do
      visit root_path
      visit post_path(@post)
      expect(page).to have_content(@post.price)
    end
    it 'calorieが表示される' do
      visit root_path
      visit post_path(@post)
      expect(page).to have_content(@post.calorie)
    end
    it 'ログインしたユーザーと投稿したユーザーが同じとき編集ボタンと削除ボタンが表示される' do
      visit root_path
      sign_in(@post.user)
      visit post_path(@post)
      expect(page).to have_link '削除', href: post_path(@post)
      expect(page).to have_link '編集', href: edit_post_path(@post)
    end
    it 'ログインしていないユーザーには編集ボタンと削除ボタンが表示されない' do
      visit root_path
      visit post_path(@post)
      expect(page).to have_no_link '削除', href: post_path(@post)
      expect(page).to have_no_link '編集', href: edit_post_path(@post)
    end
    it 'ログインしているユーザーにはコメント投稿フォームが表示される' do
      visit root_path
      sign_in(@post.user)
      visit post_path(@post)
      expect(page).to have_selector 'form'
    end
    it 'ログインしていないユーザーにはコメント投稿フォームが表示されない' do
      visit root_path
      visit post_path(@post)
      expect(page).to have_no_selector 'form'
    end
  end
end

RSpec.describe '投稿内容の編集', type: :system do
  before do
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end
  context '投稿内容が編集できるとき' do
    it 'ログインしたユーザーは自分が投稿した投稿ページの編集ができる' do
      sign_in(@post1.user)
      visit post_path(@post1)
      find_link('編集').click
      expect(current_path).to eq edit_post_path(@post1)
      fill_in 'post_content', with: '編集しました'
      click_button '編集する'
      expect(current_path).to eq post_path(@post1)
      expect(page).to have_content('編集しました')
    end
  end
  context '投稿内容が編集できないとき' do
    it 'ログインしたユーザーは、自分以外が投稿した投稿の編集画面には遷移できない' do
      sign_in(@post1.user)
      visit post_path(@post2)
      expect(current_path).to eq post_path(@post2)
      expect(page).to have_no_link '編集', href: edit_post_path(@post2)
    end
    it 'ログインしていないと、投稿の編集画面には遷移できない' do
      visit root_path
      visit post_path(@post1)
      expect(page).to have_no_link '編集', href: edit_post_path(@post1)
    end
  end
end

RSpec.describe '投稿内容の削除', type: :system do
  before do
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end
  context '投稿の削除ができるとき' do
    it 'ユーザーは、自分の投稿を削除できる' do
      sign_in(@post1.user)
      visit post_path(@post1)
      find_link('削除').click
      expect(current_path).to eq root_path
      expect(page).to have_no_content(@post1.content)
    end
  end
  context '投稿の削除ができないとき' do
    it '他のユーザーの投稿は削除できない' do
      sign_in(@post1.user)
      visit post_path(@post2)
      expect(page).to have_no_link '削除', href: post_path(@post2)
    end
    it 'ログインしていないと削除できない' do
      visit post_path(@post1)
      expect(page).to have_no_link '削除', href: post_path(@post1)
    end
  end
end
