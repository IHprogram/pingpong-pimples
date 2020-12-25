require 'rails_helper'

RSpec.describe "Likes", type: :system do
  describe 'いいね機能' do
    context 'ユーザーがログインしている時' do
      let!(:user) { FactoryBot.create(:user) }
      let!(:review) { FactoryBot.create(:review, user: user) }
      before do
        # トップページを開く
        visit root_path
        # ゲストログインボタンをクリック
        find('a[class="guest-login-btn"]').click
        # トップページ上部に「ログインしました」と表示される
        expect(page).to have_content('ログインしました')
        # レビューの詳細画面へ移動する
        visit review_path(review)
      end
      
      it 'レビューの詳細画面に「いいね！」ボタンが表示されていること' do
        expect(page).to have_content('いいね！')
      end

      it 'ユーザーが「いいね！」ボタンをクリックすれば、いいねできること' do
        # いいねボタンの表示は「いいね！」の状態
        expect(page).to have_content('いいね！')
        expect {
          # いいねボタンをクリック
          find('a[class="like-btn"]').click
          # いいねボタンをクリックした後は、いいねされた数が1つ増えた状態で表示される
          expect(page).to have_content('いいねしました！ 1')
        }.to change { Like.count }.by(1)
      end

      it 'ユーザーが「いいねしました！」ボタンをクリックすれば、いいねを解除できること' do
        # いいねボタンをクリック
        find('a[class="like-btn"]').click
        # いいねボタンをクリックした後は、いいねされた数が1つ増えた状態で表示される
        expect(page).to have_content('いいねしました！ 1')
        expect {
          # 「いいねしました！」ボタンをクリック
          find('a[class="like-btn"]').click
          # 「いいねしました」 ボタンをクリックした後は、いいねされた数が1つ減った状態で表示される
          expect(page).to have_content('いいね！ 0')
        }.to change { Like.count }.by(-1)

      end
    end

    context 'ユーザーがログインしていない時' do
      let!(:user) { FactoryBot.create(:user) }
      let!(:review) { FactoryBot.create(:review, user: user) }
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

  describe 'いいねしたレビュー一覧表示機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:review) { FactoryBot.create(:review, user: user) }

    context 'ユーザーがレビューをいいねしていれば' do
      it 'いいねされたレビューが表示されること' do
        # トップページを開く
        visit root_path
        # レビューの詳細画面へ移動する
        visit review_path(review)
        # いいねボタンをクリック
        find('a[class="like-btn"]').click
        # いいね一覧画面へ移動
        find('div[class="menu-wrapper"]').click
        find('a[class="like-link-btn"]').click
        # いいねしたレビューが表示されている
        expect(page).to have_css("img[src*='test.jpg']")
        expect(page).to have_content review.name
        expect(page).to have_content review.user.nickname
        expect(page).to have_content review.manufacture.name
        expect(page).to have_content review.evaluation.name
      end
    end
  end
end
