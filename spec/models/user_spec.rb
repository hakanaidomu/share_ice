require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー新規登録' do
      context '新規登録がうまくいくとき' do
        it 'nickname,password,password_confirmationが存在すれば登録できる' do
          expect(@user).to be_valid
        end
        it 'discriptionが空でも登録できる' do
          @user.image = nil
          expect(@user).to be_valid
        end
      end
    end

    describe '新規登録がうまく行かないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end

      it 'nicknameが9文字以上だと登録できない' do
        @user.nickname = 'a' * 9
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームは8文字以内で入力してください')
      end

      it 'emailが空では登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end

      it '重複したemailがある場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'emailに@が含まれていないとユーザー登録できない' do
        @user.email = 'aaabbb'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      
      it 'passwordが空では登録できないこと' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end

      it 'password_confirmation空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
      
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = 'a' * 5
        @user.password_confirmation = 'b' * 5
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'aaa111'
        @user.password_confirmation = '111aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end

      it 'descriptionが151文字だと登録できない' do
        @user.description = 'a' * 151
        @user.valid?
        expect(@user.errors.full_messages).to include('自己紹介文は150文字以内で入力してください')
      end

      describe 'パスワードの検証' do
        it 'パスワードと確認用パスワードが間違っている場合、無効であること' do
          @user.password = 'password'
          @user.password_confirmation = 'pass'
          @user.valid?
          expect(@user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
        end

        it 'パスワードが暗号化されていること' do
          expect(@user.encrypted_password).to_not eq 'password'
        end
      end
    end
  end
end
