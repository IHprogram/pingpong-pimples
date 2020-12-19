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
          # ajaxが完了するまで待つ
          wait_for_ajax do
            expect(page).to have_content comment.content
          end
        }.to change { Comment.count }.by(1)
      end
    end
  end
end
