require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'コメント機保存' do
    before do
      @comment = FactoryBot.build(:comment)
    end

      describe 'コメントの保存' do
        context 'コメントが保存できる場合' do
          it 'contentがあれば保存される' do
            expect(@comment).to be_valid
          end
        end
      
      
        context 'コメントが保存できない場合' do
          it 'contentが空だとコメントは保存できない' do
            @comment.content = ''
            @comment.valid?
            expect(@comment.errors.full_messages).to include('コメントを入力してください')
          end  
        
          it 'contentが31文字以上だと保存できない' do
            @comment.content = 'a' * 31
            @comment.valid?
            expect(@comment.errors.full_messages).to include('コメントは30文字以内で入力してください')
          end

          it 'ユーザーが紐付いていないとコメントは保存できない' do
            @comment.user = nil
            @comment.valid?
            expect(@comment.errors.full_messages).to include('Userを入力してください')
          end


          it '投稿が紐付いていないとコメントは保存できない' do
            @comment.post = nil
            @comment.valid?
            expect(@comment.errors.full_messages).to include('Postを入力してください')
          end
        end
      end
  end
end