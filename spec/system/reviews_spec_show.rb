require 'rails_helper'

RSpec.describe "Reviews", type: :system do
  describe "レビュー投稿画面のレイアウト確認" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:review) { FactoryBot.create(:review, user: user) }
    before do
      # トップページを開く
      visit root_path
      # ゲストログインボタンをクリック
      find('a[class="guest-login-btn"]').click
      # トップページ上部に「ログインしました」と表示される
      expect(page).to have_content('ログインしました')
      # レビューの詳細画面へ移動する。
      visit review_path(review)
    end
  end
end
