require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'タグの保存' do
    before do
      @tag = FactoryBot.build(:tag)
    end
    context '保存できた場合場合' do
      it '内容が問題ない場合' do
        expect(@tag).to be_valid
      end
    end
    context '保存できなかった場合' do
      it 'nameが空の場合' do
        @tag.name = ''
        @tag.valid?
        expect(@tag.errors.full_messages).to include("Name can't be blank")
      end
      it 'nameが重複している場合' do
        @tag.save
        tag = FactoryBot.build(:tag)
        tag.name = @tag.name
        tag.valid?
        expect(tag.errors.full_messages).to include("Name has already been taken")
      end
    end
  end
end
