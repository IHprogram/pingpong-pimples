require 'rails_helper'

RSpec.describe "Reviews", type: :system do
  describe "レビュー投稿画面のレイアウト確認" do
    context "ユーザーがプロフィール画像を設定しているとき" do
      let!(:user) { FactoryBot.create(:user, :profile_image) }
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
      
      it "投稿者のニックネームが表示されていること" do
        expect(page).to have_content user.nickname
      end
      
      it "投稿者の画像が表示されていること" do
        expect(page).to have_css("img[src*='user.jpg']")
      end

      it "「商品情報」という文字列が表示されていること" do
        expect(page).to have_content "商品情報"
      end

      it "「評価」という文字列が表示されていること" do
        expect(page).to have_content "評価"
      end

      it "「その他コメント」という文字列が表示されていること" do
        expect(page).to have_content "その他コメント"
      end

      it "投稿したレビューの内容が表示されていること" do
        # レビューの画像が表示されていることを確認
        expect(page).to have_css("img[src*='test.jpg']")
        # 商品名が表示されていることを確認
        expect(page).to have_content review.name
        # メーカー名が表示されていることを確認
        expect(page).to have_content review.manufacture.name
        # ラバーの種類が表示されていることを確認
        expect(page).to have_content review.type.name
        # 打球感が表示されていることを確認
        expect(page).to have_content review.hardness.name
        # 価格が表示されていることを確認
        expect(page).to have_content review.price
        # スピン性能に関する点数が表示されていることを確認
        expect(page).to have_content review.spin.name
        # スピード性能に関する点数が表示されていることを確認
        expect(page).to have_content review.speed.name
        # コントロール性能に関する点数が表示されていることを確認
        expect(page).to have_content review.control.name
        # 総合評価点数が表示されていることを確認
        expect(page).to have_content review.evaluation.name
        # その他コメントが表示されていることを確認
        expect(page).to have_content review.content
      end

      it "いいねボタンが存在すること" do
        expect(page).to have_css("a[class='like-btn']")
      end

      it "コメント入力フォームがあること" do
        expect(page).to have_css("textarea[id='comment_content']")
      end

      it "コメント送信ボタンがあること" do
        expect(page).to have_css("input[name='commit']")
      end

      it "「件のコメント」という文字列が表示されていること" do
        expect(page).to have_content "件のコメント"
      end
    end

    context "ユーザーがプロフィール画像を設定していないとき" do
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
      it "投稿者のプロフィール画像部分には、デフォルト画像が表示されていること" do
        expect(page).to have_css("img[src*='/assets/user-dd619b5c5319830c5177ac444d512fc6313406b6e3b8be3c4d1774044b1e8f8f.png']")
      end
    end
  end
end
