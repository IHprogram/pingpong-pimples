require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザーの新規登録' do
    let(:user) { FactoryBot.build(:user) }

    context '新規登録できる場合' do
      it 'nickname、email、password、password_confirmationが存在すれば登録できること' do
        expect(user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空では登録できないこと' do
        use.nickname = nil
        user.valid?
        expect(user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'nicknameの文字数がが30文字より多ければ登録できないこと' do
        user.nickname = 'ユーザーのニックネームは30文字以内に収めなければ登録できない'
        user.valid?
        expect(user.errors.full_messages).to include('Nickname is too long (maximum is 30 characters)')
      end

      it 'emailが空では登録できないこと' do
        user.email = nil
        user.valid?
        expect(user.errors.full_messages).to include("Email can't be blank")
      end

      it 'emailに全角が含まれていると登録できないこと' do
        user.email = 'サンプル@gmail.com'
        user.valid?
        expect(user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが空では登録できないこと' do
        user.password = nil
        user.valid?
        expect(user.errors.full_messages).to include("Password can't be blank")
      end

      it 'emailに@が含まれていない場合、保存できないこと' do
        user.email = 'sampletest.com'
        user.valid?
        expect(user.errors.full_messages).to include('Email is invalid')
      end

      it '重複したemailが存在する場合登録できないこと' do
        user.save
        another_user = FactoryBot.build(:user, email: user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'passwordが5文字以下であれば登録できないこと' do
        user.password = 'a1234'
        user.password_confirmation = 'a1234'
        user.valid?
        expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが英字のみなら保存できないこと' do
        user.password = 'aaaaaa'
        user.password_confirmation = 'aaaaaa'
        user.valid?
        expect(user.errors.full_messages).to include('Password は英字と数字の両方を含めて6文字以上のものを設定してください')
      end

      it 'passwordが数字のみなら保存できないこと' do
        user.password = '123456'
        user.password_confirmation = '123456'
        user.valid?
        expect(user.errors.full_messages).to include('Password は英字と数字の両方を含めて6文字以上のものを設定してください')
      end

      it 'passwordが存在してもpassword_confirmationが空では登録できないこと' do
        user.password_confirmation = ''
        user.valid?
        expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
