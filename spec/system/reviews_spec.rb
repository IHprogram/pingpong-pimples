require 'rails_helper'

RSpec.describe "Reviews", type: :system do
  describe "レビューの投稿を行う時" do
    context "正しい値を入力すれば" do
      let!(:review) { FactoryBot.build(:review) }
      scenario "レビューの投稿が成功すること" do
        # トップページを開く
        visit root_path
        # ゲストログインボタンをクリック
        find('a[class="guest-login-btn"]').click
        # トップページ上部に「ログインしました」と表示される
        expect(page).to have_content('ログインしました')
        # メニューボタンをクリックすると、投稿するボタンがある
        find('div[class="menu-wrapper"]').click
        expect(page).to have_content('投稿する')
        # 新規登録画面へ移動する。
        visit new_review_path
        # 画像を選択
        attach_file 'review[image]', "#{Rails.root}/spec/factories/sample.png"
        # 商品名を入力
        fill_in 'product-name', with: review.name
        # メーカーを選択
        select 'バタフライ', from: 'review[manufacture_id]'
        # ラバーの種類を選択
        select '裏ソフトラバー', from: 'review[type_id]'
        # 打球感を選択
        select '硬い（ハード）', from: 'review[hardness_id]'
        # スピンを選択
        select '10', from: 'review[spin_id]'
        # スピ-ドを選択
        select '10', from: 'review[speed_id]'
        # コントロールを選択
        select '10', from: 'review[control_id]'
        # 商品の価格を入力
        fill_in 'product-price', with: review.price
        # 総合評価の選択
        select '10', from: 'review[evaluation_id]'
        # その他コメントの入力
        fill_in 'product-info', with: review.content
        # レビューを投稿するボタンをクリックすると、レビューモデルのカウントが1上がる
        expect{
          find('input[name="commit"]').click
        }.to change{ Review.count }.by(1)
        # 新規登録に成功すれば、トップページに移動する
        expect(current_path).to eq root_path
      end
    end
  end
  
end
