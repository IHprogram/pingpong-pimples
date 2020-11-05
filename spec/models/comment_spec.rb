require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'コメントの投稿' do
    before do
      @comment = FactoryBot.build(:comment)
    end

    context 'コメントを投稿できる場合' do
      it 'contentが存在すれば投稿できること' do
        expect(@comment).to be_valid
      end
    end

    context 'コメントを投稿できない場合' do
      it 'contentが空では投稿できないこと' do
        @comment.content = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Content can't be blank")
      end
    end

  end
end
