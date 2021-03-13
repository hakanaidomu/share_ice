require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '新規投稿' do
    before do
      @post = FactoryBot.build(:post)
      @post.tag_list = %w[抹茶 バニラ チョコ]
    end

    describe '新規投稿' do
      context '新規投稿がうまくいく時' do
        it 'content,imageがあれば新規投稿ができる' do
          expect(@post).to be_valid
        end
        it 'priceが空でも登録できる' do
          @post.price = nil
          expect(@post).to be_valid
        end
        it 'calorieが空でも登録できる' do
          @post.calorie = nil
          expect(@post).to be_valid
        end
        it 'tag_listが空でも登録できる' do
          @post.tag_list = nil
          expect(@post).to be_valid
        end
      end
      describe '新規投稿がうまく行かないとき' do
        it 'contentが空では登録できない' do
          @post.content = nil
          @post.valid?
          expect(@post.errors.full_messages).to include('アイスの感想を入力してください')
        end

        it 'imageが空では登録できない' do
          @post.image = nil
          @post.valid?
          expect(@post.errors.full_messages).to include('画像を入力してください')
        end
        it 'contentが151文字以上では登録できない' do
          @post.content = 'a' * 151
          @post.valid?
          expect(@post.errors.full_messages).to include('アイスの感想は150文字以内で入力してください')
        end

        it 'priceが1000以上では登録できない' do
          @post.price = 1000
          @post.valid?
          expect(@post.errors.full_messages).to include('値段は999以下の値にしてください')
        end

        it 'priceが全角数字では登録できない' do
          @post.price = '１００'
          @post.valid?
          expect(@post.errors.full_messages).to include('値段は数値で入力してください')
        end

        it 'priceが半角数字以外では登録できない' do
          @post.price = 'aaa'
          @post.valid?
          expect(@post.errors.full_messages).to include('値段は数値で入力してください')
        end

        it 'calorieが1000以上では登録できない' do
          @post.calorie = 1000
          @post.valid?
          expect(@post.errors.full_messages).to include('カロリーは999以下の値にしてください')
        end

        it 'calorieが全角数字では登録できない' do
          @post.calorie = '１００'
          @post.valid?
          expect(@post.errors.full_messages).to include('カロリーは数値で入力してください')
        end

        it 'calorieが半角数字以外では登録できない' do
          @post.calorie = 'aaa'
          @post.valid?
          expect(@post.errors.full_messages).to include('カロリーは数値で入力してください')
        end

        it 'ユーザーが紐付いていないと投稿は保存できない' do
          @post.user = nil
          @post.valid?
          expect(@post.errors.full_messages).to include('Userを入力してください')
        end
      end
    end
  end
end
