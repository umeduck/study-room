require 'rails_helper'

RSpec.describe "Rooms", type: :system do
  before do
    @room = FactoryBot.build(:room)
    @user = FactoryBot.create(:user)
  end
  describe 'ルームの作成' do
    context 'ルームを作成できた場合' do
      it 'ログインを行なっており必要事項に記入していればルームを作成できる' do
        # ログインを行う
        sign_in(@user)
        # トップページにルーム作成ボタンがあるかを確認
        expect(page).to have_content('ルームの作成')
        # ルーム作成ページへ遷移
        visit new_room_path
        # フォームに入力を行う
        fill_in 'ルーム名', with: @room.title
        fill_in 'タグ', with: 'タグ'
        # ルーム作成ボタンを押すとルームモデルのカウントが一つ上がることを確認
        expect{
          find('input[name="commit"]').click
        }.to change {Room.count}.by(1)
        # トップページへ遷移いているか確認
        expect(current_path).to eq(root_path)
        # トップページに作成したルームが表示されているか確認
        expect(page).to have_content(@room.title)
      end
      it 'タグを記述しなくてもルームを作成することができる' do
       # ログインを行う
       sign_in(@user)
       # トップページにルーム作成ボタンがあるかを確認
       expect(page).to have_content('ルームの作成')
       # ルーム作成ページへ遷移
       visit new_room_path
       # フォームに入力を行う
       fill_in 'ルーム名', with: @room.title
       # ルーム作成ボタンを押すとルームモデルのカウントが一つ上がることを確認
       expect{
         find('input[name="commit"]').click
       }.to change {Room.count}.by(1)
       # トップページへ遷移いているか確認
       expect(current_path).to eq(root_path)
       # トップページに作成したルームが表示されているか確認
       expect(page).to have_content(@room.title)
      end
    end
    context 'ルームを作成できなかった場合' do
      it 'ログインしていなければルーム作成できない' do
        # トップページへ遷移
        visit root_path
        # トップページにルーム作成ボタンがないことを確認
        expect(page).to have_no_content('ルームの作成')
        # ルーム作成ページに遷移しようとするとログインページへ遷移される
        visit new_room_path
        expect(current_path).to eq(new_user_session_path)
      end
      it '必要事項に記入していなければルームの作成ができない' do
        # ログインを行う
        sign_in(@user)
        # ルーム作成ページへ遷移
        visit new_room_path
        # ルーム名が空でルーム作成ボタンを押しルームモデルに保存をされないことを確認
        expect{
          find('input[name="commit"]').click
        }.to change {Room.count}.by(0)
        # ルーム作成画面に戻っていることを確認
        expect(current_path).to eq(rooms_path)
      end
    end
  end
end
