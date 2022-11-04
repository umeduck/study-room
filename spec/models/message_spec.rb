require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'メッセージの投稿' do
    before do
      @message = FactoryBot.build(:message)
    end
    context 'メッセージ投稿できた場合' do
      it '内容が問題なく投稿できた場合' do
        expect(@message).to be_valid
      end
    end
    context 'メッセージが投稿できなかった場合' do
      it 'contentが空の場合' do
        @message.content = ''
        @message.valid?
        expect(@message.errors.full_messages).to include("Content can't be blank")
      end
      it 'roomと紐づいていない場合' do
        @message.room = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Room must exist")
      end
      it 'userと紐づいた場合' do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("User must exist")
      end
    end
  end
end
