require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  context 'いいね機能処理' do
    context 'ログインしている場合' do
      let!(:user) { FactoryBot.create(:user) }
      let!(:review) { FactoryBot.create(:review) }

      context 'ユーザーがログインしている場合' do
        it 'いいねは保存されること' do
          sign_in user
          expect {
            post :create, format: ['text/html'], params: { user_id: user.id, review_id: review.id }
          }.to change { Like.count }.by(1)
        end
      end
    end
  end
end
