require 'rails_helper'

RSpec.describe "Comments", type: :system do
  describe "コメント投稿機能" do
    let!(:review) { FactoryBot.create(:review) }
    let!(:comment) { FactoryBot.build(:comment, review: review) }
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

    context 'ユーザーがコメント入力フォームに正常な値を入力すれば' do
      it 'コメントを投稿できること' do
        fill_in 'comment_content', with: comment.content
        expect {
          find('input[id="comment-button"]').click
          expect(page).to have_css '.open-btn'
          # ajaxが完了するまで待つ
          wait_for_ajax do
            expect(page).to have_content comment.content
          end
        }.to change { Comment.count }.by(1)
      end
    end

    context 'コメント入力フォームが空欄のままで、コメント送信ボタンをクリックすれば' do
      it 'コメントを投稿できないこと（コメント送信ボタンがクリックできないようになっている）' do
        expect(page).to have_css '.close-btn'
      end
    end
  end

  describe "コメント削除機能" do
    let!(:review) { FactoryBot.create(:review) }
    let!(:comment) { FactoryBot.build(:comment, review: review) }
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

    it 'コメントを削除できること' do
      fill_in 'comment_content', with: comment.content
      find('input[id="comment-button"]').click
      find('a[class="comment-delete-btn"]').click
      expect {
        expect(page.accept_confirm).to eq "コメントを完全に削除してもよろしいですか？"
        expect(page).to have_content "0"
        expect(page).to have_content "件のコメント"
      }.to change{ Comment.count }.by(-1)
    end
  end
end
