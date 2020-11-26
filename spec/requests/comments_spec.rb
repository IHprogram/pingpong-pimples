require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) }
    let(:review) { FactoryBot.create(:review, user: user) }

    it 'コメントを投稿できること' do
      comment_params = FactoryBot.attributes_for(:comment, review: review)
      sign_in user
      expect do
        post :create, format: ['text/html'], params: { review_id: review.id, comment: comment_params }
      end.to change(review.comments, :count).by(1)
    end

    it 'コメントを投稿できないこと' do
      comment_params = FactoryBot.attributes_for(:comment, :invalid)
      sign_in user
      expect do
        post :create, format: ['text/html'], params: { review_id: review.id, comment: comment_params }
      end.to_not change(user.comments, :count)
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { FactoryBot.create(:user) }
    let(:review) { FactoryBot.create(:review, user: user) }
    let!(:comment) { FactoryBot.create(:comment, review: review) }

    context 'コメントを投稿したユーザー本人であれば' do
      it 'コメントを削除できること' do
        sign_in user
        expect do
          delete :destroy, format: ['text/html'], params: { id: comment.id }
        end.to change { Comment.count }.by(-1)
      end
    end
  end
end
