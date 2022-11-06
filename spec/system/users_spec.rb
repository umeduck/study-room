require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
    @user_login = FactoryBot.create(:user)
  end
  describe '新規登録' do
    context 'ユーザー新規登録ができるとき' do 
      it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
        # トップページに移動
        visit root_path
        # トップページにサインアップページへ遷移するボタンがあることを確認
        expect(page).to have_content('新規登録')
        # 新規登録ページへ移動
        visit  new_user_registration_path
        # ユーザー情報を入力
        fill_in '名前', with: @user.name
        select '中学１年', from: 'item-sales-status'
        fill_in 'メールアドレス', with: @user.email
        fill_in 'パスワード', with: @user.password
        fill_in 'パスワード（確認）', with: @user.password
        # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認
        expect{
          find('input[name="commit"]').click
        }.to change {User.count}.by(1)
        # トップページへ遷移したことを確認する
        expect(current_path).to eq(root_path)
        # トップページにログアウトボタンがあるか確認
        expect(page).to have_content('ログアウト')
        # トップページにログインボタンと新規登録ボタンがないことを確認
        expect(page).to have_no_content('新規登録')
        expect(page).to have_no_content('ログイン')
      end
    end
    context 'ユーザー新規登録ができないとき' do
      it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
        # トップページに移動
        visit root_path
        # トップページにサインアップページへ遷移するボタンがあることを確認
        expect(page).to have_content('新規登録')
        # 新規登録ページへ移動
        visit new_user_registration_path
        # ユーザー情報を入力
        fill_in '名前', with: @user.name
        select '中学１年', from: 'item-sales-status'
        fill_in 'メールアドレス', with: @user.email
        fill_in 'パスワード', with: @user.password
        # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認
        expect{
          find('input[name="commit"]').click
        }.to change {User.count}.by(0)
        # 新規登録ページへ戻されることを確認する
        expect(current_path).to eq(user_registration_path)
      end
    end
  end
  describe 'ログイン機能' do
    context 'ユーザーログインができるとき' do
      it '正しい情報を入力すればログインできる' do
        # トップページへ移動
        visit root_path
        # トップページにログインページへ遷移するボタンがあることを確認
        expect(page).to have_content('ログイン')
        # ログインページへ移動
        visit new_user_session_path
        # 登録されているユーザー情報を入力
        fill_in 'メールアドレス',with: @user_login.email
        fill_in 'パスワード', with: @user_login.password
        # ログインボタンを押したらログインを行う
        find('input[name="commit"]').click
        # トップページへ遷移していることを確認
        expect(current_path).to eq(root_path)
        # トップページにログアウトばボタンがあることを確認
        expect(page).to have_content('ログアウト')
        # トップページにログインボタンと新規登録ボタンがないことを確認
        expect(page).to have_no_content('新規登録')
        expect(page).to have_no_content('ログイン')
      end
    end
    context 'ログインできないとき' do
      it '登録されていないユーザー情報ではログインできない' do
        # トップページへ移動
        visit root_path
        # トップページログインページへ遷移するボタンがあることを確認
        expect(page).to have_content('ログイン')
        # ログインページへ遷移
        visit new_user_session_path
        # 登録されていないユーザー情報の入力
        user = FactoryBot.build(:user)
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        # ログインボタンを押す
        find('input[name="commit"]').click
        # ログインはできずログインページへ戻される
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
  describe 'ユーザー編集機能' do
    context 'ユーザー情報を変更をできた場合' do
      it '必要事項を入力した場合保存できる' do
        # ログインを行う
        sign_in(@user_login)
        # トップページにユーザー編集ページ遷移ボタンが存在するか確認
        expect(page).to have_content('ユーザー編集')
        # ユーザー編集ページへ遷移する
        visit edit_user_path(@user_login.id)
        # 必要事項を入力する
        fill_in '名前', with: '太郎'
        # 編集確定ボタンを押す
        find('input[name="commit"]').click
        # トップページへ遷移しているか確認する
        expect(current_path).to eq(root_path)
        # 名前が変更されているか確認
        expect(page).to have_content('太郎')
      end
    end
    context 'ユーザー情報を変更できなかった場合' do
      it '必要事項が空の場合保存できない' do
        # ログインを行う
        @user_login = FactoryBot.create(:user)
        sign_in(@user_login)
        # ユーザー編集ページへ移動する
        visit edit_user_path(@user_login.id)
        # 誤った入力を行う
        fill_in '名前', with: ''
        # 編集確定ボタンを押す
        find('input[name="commit"]').click
        # 編集内容が登録されておらず編集ページに戻る
        expect(current_path).to eq(user_path(@user_login.id))
      end
    end
  end
end
