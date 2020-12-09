require 'rails_helper'

RSpec.describe "Reviews", type: :system do
  describe "レビュー投稿画面のレイアウト確認" do
    let!(:review) { FactoryBot.build(:review) }
    before do
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
    end

    it "「- レビュー内容の入力 -」というタイトルが存在すること" do
      expect(page).to have_content '- レビュー内容の入力 -'
    end

    it "入力部分に適切なラベルが表示されること" do
      expect(page).to have_content '商品画像（必須）'
      expect(page).to have_content 'メーカー（必須）'
      expect(page).to have_content 'ラバーの種類（必須）'
      expect(page).to have_content '打球感（必須）'
      expect(page).to have_content 'スピン（必須・10点満点中）'
      expect(page).to have_content 'スピード（必須・10点満点中）'
      expect(page).to have_content 'コントロール（必須・10点満点中）'
      expect(page).to have_content '商品の価格（必須・半角数字で入力してください）'
      expect(page).to have_content '総合評価（必須・10点満点中）'
      expect(page).to have_content 'その他コメント（必須）'
      expect(page).to have_content '動画（任意）'
    end
  end

  describe "レビューの投稿を行う時" do
    let!(:review) { FactoryBot.build(:review) }
    before do
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
    end

    context "正しい値を入力すれば" do
      it "レビューの投稿が成功すること" do
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

    context "誤った値を入力すれば" do
      it "レビューを投稿できず、エラーメッセージが表示されること" do
        # メーカーを選択
        select '--', from: 'review[manufacture_id]'
        # ラバーの種類を選択
        select '--', from: 'review[type_id]'
        # 打球感を選択
        select '--', from: 'review[hardness_id]'
        # スピンを選択
        select '--', from: 'review[spin_id]'
        # スピ-ドを選択
        select '--', from: 'review[speed_id]'
        # コントロールを選択
        select '--', from: 'review[control_id]'
        # 商品の価格を入力
        fill_in 'product-price', with: "0"
        # 総合評価の選択
        select '--', from: 'review[evaluation_id]'
        # レビューを投稿するボタンをクリックする（画像、商品名、その他コメントは空欄）
        find('input[name="commit"]').click

        # エラーメッセージが表示される
        expect(page).to have_content('画像を入力してください')
        expect(page).to have_content('商品名を入力してください')
        expect(page).to have_content('メーカーは「--」以外の項目を選択してください')
        expect(page).to have_content('ラバーの種類は「--」以外の項目を選択してください')
        expect(page).to have_content('スピンは「--」以外の項目を選択してください')
        expect(page).to have_content('スピードは「--」以外の項目を選択してください')
        expect(page).to have_content('コントロールは「--」以外の項目を選択してください')
        expect(page).to have_content('打球感は「--」以外の項目を選択してください')
        expect(page).to have_content('総合評価は「--」以外の項目を選択してください')
        expect(page).to have_content('価格は0より大きい半角数字で入力してください')
        expect(page).to have_content('その他コメントを入力してください')
      end

      it "空欄でなくても入力した値が誤っていれば、レビューを投稿できず、エラーメッセージが表示されること" do
        # 商品の価格を入力（全角文字）
        fill_in 'product-price', with: "１０００"
        # レビューを投稿するボタンをクリックする
        find('input[name="commit"]').click
        # レビューは投稿できず、違うエラーメッセージが表示される
        expect(page).to have_content('価格は0より大きい半角数字で入力してください')
      end
    end
  end
end
