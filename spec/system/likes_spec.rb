require 'rails_helper'

RSpec.describe "Likes", type: :system do
  describe 'いいね機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:review) { FactoryBot.create(:review, user: user) }    

    context 'ユーザーがログインしていない時' do
      before do
        # トップページを開く
        visit root_path
        # レビューの詳細画面へ移動する
        visit review_path(review)
      end

      it 'いいねボタンをクリックすると、ログイン画面に移動すること' do
        find('a[class="like-btn"]').click
        expect(current_path).to eq new_user_session_path
      end
    end
  end
end
