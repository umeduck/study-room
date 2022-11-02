require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー登録' do
    before do
      @user = FactoryBot.create(:user)
    end
    context 'ユーザー登録に問題ない場合' do
      it 'すべての内容が正しく入力れている' do
        expect(@user).to be_valid
      end
    end
    context 'ユーザー登録に問題がある場合' do
      it 'nameが空の場合' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end
      it 'emailが空の場合' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailに@がついていない場合' do
        @user.email = 'aaa00000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'emailは重複していた場合' do
        @user.save
        user = FactoryBot.create(:user)
        user.email = @user.email
        user.valid?
        expect(user.errors.full_messages).to include("Email has already been taken")
      end
      it 'passwordが空の場合' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが129文字以上の場合' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end
      it 'passwordが5文字以下の場合' do
        @user.password = 'aaa00'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordとpassword_confirmationが不一致の場合' do
        @user.password = '0000aaaaa'
        @user.password_confirmation = 'aaaaaa000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'school_year_idが空の場合' do
        @user.school_year_id = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("School year can't be blank")
      end
      it 'school_year_idが1の場合' do
        @user.school_year_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("School year can't be blank")
      end
    end
  end
end
