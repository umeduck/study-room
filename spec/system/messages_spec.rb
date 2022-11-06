require 'rails_helper'

RSpec.describe "Messages", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @room = FactoryBot.create(:room)
    @message = FactoryBot.build(:message)
  end

  describe 'メッセージの投稿機能' do
    context 'メッセージの投稿ができた場合' do
      it 'ログインを行なっていて必要事項を記入すればメッセージを投稿できる' do
        # ログインを行う
        sign_in(@user)
        # ルームの作成を行う
        # room_create(@room)
        # 作成したルームの名前のリンクがトップページに存在するか確認
        expect(page).to have_content(@room.title)
        # 作成したルームのメッセージ画面へと遷移
        visit room_messages_path(@room.id)
        # メッセージのフォームに記述
        fill_in 'message[content]', with: @message.content
        # 送信ボタンを押したらメッセージモデルに保存されることを確認
        expect{
          find('input[name="commit"]').click
        }.to change {Message.count}.by(1)
        # 投稿したのちメッセージ画面にいることを確認
        expect(current_path).to eq(room_messages_path(@room.id))
        # 投稿したメッセージ内容が表示されているか確認
        expect(page).to have_content(@message.content)
      end
    end
    context 'メッセージの投稿ができない場合' do
       it 'ログインを行なっていなければメッセージの投稿ができない' do
        # 作成したルームメッセージ画面へと遷移
        visit room_messages_path(@room.id)
        # メッセージ画面にはフォームが存在しないことを確認
        expect(page).to have_no_field('message_content')
       end
       it 'メッセージフォームが空では投稿できない' do
        # ログインを行う
        sign_in(@user)
        # 作成したルームメッセージ画面へと遷移する
        visit room_messages_path(@room.id)
        # フォームは空のまま送信ボタンを押してもメッセージテーブルには保存されないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change {Message.count}.by(0)
        # メッセージが保存されなくてもメッセージ画面へと遷移していることを確認
        expect(current_path).to eq(room_messages_path(@room.id))
       end
    end
  end
end
