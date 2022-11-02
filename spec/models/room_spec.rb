require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'ルームの作成' do
    before do
      @room = FactoryBot.build(:room)
    end
    context 'ルームの作成が問題ない場合' do
      it '内容が問題なく入力された場合' do
        expect(@room).to be_valid
      end
    end
    context 'ルームの作成が問題がある場合' do
      it 'titleが空の場合' do
        @room.title = ''
        @room.valid?
        expect(@room).to include("Title can't be blank")
      end
      it 'userモデルが紐づいていない場合' do
        @room.user = nil
        @room.valid?
        expect(@room).to include("User must exist")
      end
    end
  end
end
