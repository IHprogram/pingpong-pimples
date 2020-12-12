require 'rails_helper'

RSpec.describe 'Reviews', type: :system do
  describe 'レビュー投稿機能' do
    describe 'レビュー投稿画面のレイアウト確認' do
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

      it '「- レビュー内容の入力 -」というタイトルが存在すること' do
        expect(page).to have_content '- レビュー内容の入力 -'
      end

      it '入力部分に適切なラベルが表示されること' do
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

      it '画像のアップロード部分が表示されること' do
        expect(page).to have_css 'input[type=file]'
        expect(page).to have_css 'input[accept="image/jpg, image/png"]'
      end

      it '動画のアップロード部分が表示されること' do
        expect(page).to have_css 'input[type=file]'
        expect(page).to have_css 'input[accept="video/mp4"]'
      end

      it '「トップページにもどる」ボタンをクリックすればトップページに移動すること' do
        find('a[class="new-back-btn"]').click
        expect(current_path).to eq root_path
      end
    end

    describe 'レビューの投稿を行う時' do
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

      context '正しい値を入力すれば' do
        it 'レビューの投稿が成功すること' do
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
          expect {
            find('input[name="commit"]').click
          }.to change { Review.count }.by(1)
          # 新規登録に成功すれば、トップページに移動する
          expect(current_path).to eq root_path
        end

        it '任意で動画のアップロードもできること' do
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

          #  動画を選択
          attach_file 'review[video]', "#{Rails.root}/spec/factories/test_movie.mp4"

          # レビューを投稿するボタンをクリックすると、レビューモデルのカウントが1上がる
          expect {
            find('input[name="commit"]').click
          }.to change { Review.count }.by(1)
          # 新規登録に成功すれば、トップページに移動する
          expect(current_path).to eq root_path
        end
      end

      context '誤った値を入力すれば' do
        it 'レビューを投稿できず、エラーメッセージが表示されること' do
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
          fill_in 'product-price', with: '0'
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

        it '空欄でなくても入力した値が誤っていれば、レビューを投稿できず、エラーメッセージが表示されること' do
          # 商品の価格を入力（全角文字）
          fill_in 'product-price', with: '１０００'
          # レビューを投稿するボタンをクリックする
          find('input[name="commit"]').click
          # レビューは投稿できず、違うエラーメッセージが表示される
          expect(page).to have_content('価格は0より大きい半角数字で入力してください')
        end
      end
    end
  end

  describe 'レビュー詳細表示機能' do
    describe 'レビュー詳細画面のレイアウト確認' do
      context 'ユーザーがプロフィール画像を設定しているとき' do
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

        it '投稿者のニックネームが表示されていること' do
          expect(page).to have_content user.nickname
        end

        it '投稿者の画像が表示されていること' do
          expect(page).to have_css("img[src*='user.jpg']")
        end

        it "投稿者のニックネームや画像をクリックすると、投稿者のプロフィール画面へ遷移すること" do
          find('a[class="user-profile-link"]').click
          expect(current_path).to eq user_path(user)
        end

        it '「商品情報」という文字列が表示されていること' do
          expect(page).to have_content '商品情報'
        end

        it '「評価」という文字列が表示されていること' do
          expect(page).to have_content '評価'
        end

        it '「その他コメント」という文字列が表示されていること' do
          expect(page).to have_content 'その他コメント'
        end

        it '投稿したレビューの内容が表示されていること' do
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

        it 'いいねボタンが存在すること' do
          expect(page).to have_css("a[class='like-btn']")
        end

        it 'コメント入力フォームがあること' do
          expect(page).to have_css("textarea[id='comment_content']")
        end

        it 'コメント送信ボタンがあること' do
          expect(page).to have_css("input[name='commit']")
        end

        it '「件のコメント」という文字列が表示されていること' do
          expect(page).to have_content '件のコメント'
        end
      end

      context 'ユーザーがプロフィール画像を設定していないとき' do
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
        
        it '投稿者のプロフィール画像部分には、デフォルト画像が表示されていること' do
          expect(page).to have_css("img[src*='/assets/user-dd619b5c5319830c5177ac444d512fc6313406b6e3b8be3c4d1774044b1e8f8f.png']")
        end
      end

      context "ユーザーがログインしている時" do
        let!(:user) { FactoryBot.create(:user) }
        let!(:review) { FactoryBot.create(:review, user: user) }
        before do
          # サインインする
          sign_in user
          # トップページを開く
          visit root_path
          # レビューの詳細画面へ移動する。
          visit review_path(review)
        end

        it "レビュー編集ボタンが表示されていること" do
          expect(page).to have_css("a[class='edit-btn']")
        end
        
        it "レビュー削除ボタンが表示されていること" do
          expect(page).to have_css("a[class='delete-btn']")
        end
      end

      context "ユーザーがログインしていない時（ログアウト状態の時）" do
        let!(:user) { FactoryBot.create(:user) }
        let!(:review) { FactoryBot.create(:review, user: user) }
        before do
          # トップページを開く
          visit root_path
          # レビューの詳細画面へ移動する。
          visit review_path(review)
        end
        
        it "レビュー編集ボタンが表示されていないこと" do
          expect(page).not_to have_css("a[class='edit-btn']")
        end
        
        it "レビュー削除ボタンが表示されていないこと" do
          expect(page).not_to have_css("a[class='delete-btn']")
        end
      end

      context "レビューの投稿者ではない他ユーザーがレビュー詳細画面に移動した時" do
        let!(:user) { FactoryBot.create(:user) }
        let!(:review) { FactoryBot.create(:review, user: user) }
        let!(:other_user) { FactoryBot.create(:user) }
        before do
          # サインインする
          sign_in other_user
          # トップページを開く
          visit root_path
          # レビューの詳細画面へ移動する。
          visit review_path(review)
        end
        
        it "レビュー編集ボタンが表示されていないこと" do
          expect(page).not_to have_css("a[class='edit-btn']")
        end
        
        it "レビュー削除ボタンが表示されていないこと" do
          expect(page).not_to have_css("a[class='delete-btn']")
        end
      end
    end
  end
end
