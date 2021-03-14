require 'rails_helper'

RSpec.describe 'コメント投稿機能', type: :system do
  before do
    @post = FactoryBot.create(:post)
    @comment = FactoryBot.build(:comment)
  end
  context 'コメントができるとき' do
    it 'ログインしたユーザーは投稿詳細ページでコメントを投稿できる' do
      sign_in(@post.user)
      visit post_path(@post)
      fill_in 'comment_content', with: @comment.content
      expect  do
        find('input[name="commit"]').click
        sleep 1
      end.to change {Comment.count}.by(1)
      expect(page).to have_content(@comment.content)
    end
    it 'ログインしたユーザーは投稿詳細ページで自身のコメントを削除できる' do
      sign_in(@post.user)
      visit post_path(@post)
      fill_in 'comment_content', with: @comment.content
      click_button '送信'
      find_link('コメントを削除').click
      expect(page).to have_no_content(@comment.content)
    end
  end
  context 'コメントができないとき' do
    it 'ログインしていないユーザーは投稿詳細ページでコメントを投稿できない' do
      visit post_path(@post)
      expect(page).to have_no_link '送信', href: post_path(@post)
    end
  end
end

