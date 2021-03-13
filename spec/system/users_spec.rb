require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      visit root_path
      expect(page).to have_link 'シェアあいす!', href: root_path
      expect(page).to have_link 'トップページ', href: root_path
      expect(page).to have_link 'ログイン', href: new_user_session_path
      expect(page).to have_link '新規登録', href: new_user_registration_path
      expect(page).to have_link 'かんたんログイン', href: users_guest_sign_in_path
      visit new_user_registration_path
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      expect(current_path).to eq root_path
      expect(page).to have_link 'シェアあいす!', href: root_path
      expect(page).to have_link 'トップページ', href: root_path
      expect(page).to have_link '新規投稿', href: new_post_path
      expect(page).to have_link 'ログアウト', href: destroy_user_session_path
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      visit root_path
      visit new_user_registration_path
      fill_in 'user_nickname', with: ''
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      fill_in 'user_password_confirmation', with: ''
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      expect(current_path).to eq '/users'
    end
  end
end

RSpec.describe 'ユーザーログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      visit root_path
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      expect(page).to have_no_link 'ログイン', href: new_user_session_path
      expect(page).to have_no_link 'かんたんログイン', href: new_user_session_path
      expect(page).to have_no_link '新規登録', href: new_user_registration_path
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      visit root_path
      visit new_user_session_path
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
    end
  end
end

RSpec.describe 'ユーザーログアウト', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログアウトができるとき' do
    it 'ログインしたユーザーはログアウトができる' do
      visit root_path
      sign_in(@user)
      expect(page).to have_link 'ログアウト', href: destroy_user_session_path
      first(:link, 'ログアウト').click
      expect(page).to have_no_link 'ログアウト', href: destroy_user_session_path
    end
  end
  context 'ログアウトができない' do
    it 'ログインしていないユーザーにはログアウトボタンが表示されない' do
      visit root_path
      expect(page).to have_no_link 'ログアウト', href: destroy_user_session_path
    end
  end
end

RSpec.describe 'ユーザー編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
end
