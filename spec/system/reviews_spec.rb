require 'rails_helper'

RSpec.describe 'Reviews', type: :system do
  describe 'トップ画面のレイアウト確認' do
    let!(:review) { FactoryBot.build(:review) }
    before do
      # トップページを開く
      visit root_path
      # ゲストログインボタンをクリック
      find('a[class="guest-login-btn"]').click
      # トップページ上部に「ログインしました」と表示される
      expect(page).to have_content('ログインしました')
    end

    describe 'ヘッダーのレイアウト確認' do
      it 'ヘッダーにロゴがあること' do
        expect(page).to have_content('Ping Pong Pimples')
      end

      it 'ヘッダーにメニューバーがあること' do
        expect(page).to have_css 'div[id=menu-btn]'
      end

      it 'メニューバーをクリックすると、メニューバーに「active」というクラス名が追加されること' do
        find('div[id=menu-btn]').click
        # クラス名は「.」をつけて記述する
        expect(page).to have_css '.active'
      end
    end

    describe 'トップページのレイアウト確認' do
      before do
        # トップページを開く
        visit root_path
      end

      it 'トップページにキャッチコピーが表示されている' do
        expect(page).to have_content('ラバー選び、もう悩まない。')
      end

      it 'トップページに説明文が表示されている' do
        expect(page).to have_content('Ping Pong Pimplesは、卓球のラバーについてレビューを投稿できるサービスです。')
        expect(page).to have_content('あらゆるレビューを参考にし、自分に合った最適なラバーを選びましょう。')
      end

      it '検索フォームが表示されていること' do
        expect(page).to have_content('- レビュー検索 -')
      end

      it '最新レビュー一覧が表示されていること' do
        expect(page).to have_content('- 最新レビュー -')
      end
    end

    describe 'フッターのレイアウト確認' do
      before do
        # トップページを開く
        visit root_path
      end
      it 'フッターにコピーライトが表示されていること' do
        expect(page).to have_content('©︎ 2020 Hiroyasu Iida')
      end
    end
  end

  describe 'レビュー検索機能の確認' do
    before do
      # トップページを開く
      visit root_path
    end
    it '検索フォーム内に入力フォームがあること' do
      expect(page).to have_css 'input[id=q_name_cont]'
    end

    it '検索フォーム内に検索ボタンがあること' do
      expect(page).to have_css '.search-btn'
    end

    it '検索フォーム内に「ラバーの種類」という文字列と、ラバーの種類に関するラジオボタンがあること' do
      expect(page).to have_content('ラバーの種類')
      find('label[for=q_type_id_eq]').click
      expect(page).to have_css 'input[id=q_type_id_eq_]'
      expect(page).to have_css 'input[id=q_type_id_eq_2]'
      expect(page).to have_css 'input[id=q_type_id_eq_3]'
      expect(page).to have_css 'input[id=q_type_id_eq_4]'
      expect(page).to have_css 'input[id=q_type_id_eq_5]'
      expect(page).to have_css 'input[id=q_type_id_eq_6]'
      expect(page).to have_css 'input[id=q_type_id_eq_7]'
    end

    it '検索フォーム内に「メーカー」という文字列と、メーカーに関するラジオボタンがあること' do
      expect(page).to have_content('メーカー')
      find('label[for=q_manufacture_id_eq]').click
      expect(page).to have_css 'input[id=q_manufacture_id_eq_]'
      expect(page).to have_css 'input[id=q_manufacture_id_eq_2]'
      expect(page).to have_css 'input[id=q_manufacture_id_eq_3]'
      expect(page).to have_css 'input[id=q_manufacture_id_eq_4]'
      expect(page).to have_css 'input[id=q_manufacture_id_eq_5]'
      expect(page).to have_css 'input[id=q_manufacture_id_eq_6]'
      expect(page).to have_css 'input[id=q_manufacture_id_eq_7]'
      expect(page).to have_css 'input[id=q_manufacture_id_eq_8]'
      expect(page).to have_css 'input[id=q_manufacture_id_eq_9]'
      expect(page).to have_css 'input[id=q_manufacture_id_eq_11]'
      expect(page).to have_css 'input[id=q_manufacture_id_eq_12]'
      expect(page).to have_css 'input[id=q_manufacture_id_eq_13]'
      expect(page).to have_css 'input[id=q_manufacture_id_eq_14]'
      expect(page).to have_css 'input[id=q_manufacture_id_eq_15]'
      expect(page).to have_css 'input[id=q_manufacture_id_eq_16]'
      expect(page).to have_css 'input[id=q_manufacture_id_eq_17]'
      expect(page).to have_css 'input[id=q_manufacture_id_eq_18]'
      expect(page).to have_css 'input[id=q_manufacture_id_eq_19]'
      expect(page).to have_css 'input[id=q_manufacture_id_eq_20]'
      expect(page).to have_css 'input[id=q_manufacture_id_eq_21]'
    end

    it '検索フォーム内に「価格」という文字列と、価格に関するラジオボタンがあること' do
      expect(page).to have_content('価格')
      find('label[for=q_price_lteq]').click
      expect(page).to have_css 'input[id=q_price_lteq_3000]'
      expect(page).to have_css 'input[id=q_price_lteq_4000]'
      expect(page).to have_css 'input[id=q_price_lteq_5000]'
      expect(page).to have_css 'input[id=q_price_lteq_6000]'
      expect(page).to have_css 'input[id=q_price_lteq_7000]'
      expect(page).to have_css 'input[id=q_price_lteq_8000]'
      expect(page).to have_css 'input[id=q_price_gt_8000]'
    end
  end

  describe 'トップ画面における最新レビュー一覧表示機能' do
    let!(:review) { FactoryBot.create(:review) }
    before do
      # トップページを開く
      visit root_path
      # ゲストログインボタンをクリック
      find('a[class="guest-login-btn"]').click
      # トップページ上部に「ログインしました」と表示される
      expect(page).to have_content('ログインしました')
    end

    it 'トップページに、レビューの商品名、ユーザー名、メーカー名、総合評価点数が表示されていること' do
      expect(page).to have_css("img[src*='test.jpg']")
      expect(page).to have_content review.name
      expect(page).to have_content review.user.nickname
      expect(page).to have_content review.manufacture.name
      expect(page).to have_content review.evaluation.name
    end
  end

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
        click_on 'トップページにもどる'
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

        it '投稿者のニックネームや画像をクリックすると、投稿者のプロフィール画面へ遷移すること' do
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

      context 'ユーザーがログインしている時' do
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

        it 'レビュー編集ボタンが表示されていること' do
          expect(page).to have_css("a[class='edit-btn']")
        end

        it 'レビュー削除ボタンが表示されていること' do
          expect(page).to have_css("a[class='delete-btn']")
        end
      end

      context 'ユーザーがログインしていない時（ログアウト状態の時）' do
        let!(:user) { FactoryBot.create(:user) }
        let!(:review) { FactoryBot.create(:review, user: user) }
        before do
          # トップページを開く
          visit root_path
          # レビューの詳細画面へ移動する。
          visit review_path(review)
        end

        it 'レビュー編集ボタンが表示されていないこと' do
          expect(page).not_to have_css("a[class='edit-btn']")
        end

        it 'レビュー削除ボタンが表示されていないこと' do
          expect(page).not_to have_css("a[class='delete-btn']")
        end
      end

      context 'レビューの投稿者ではない他ユーザーがレビュー詳細画面に移動した時' do
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

        it 'レビュー編集ボタンが表示されていないこと' do
          expect(page).not_to have_css("a[class='edit-btn']")
        end

        it 'レビュー削除ボタンが表示されていないこと' do
          expect(page).not_to have_css("a[class='delete-btn']")
        end
      end
    end
  end

  describe 'レビュー編集機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:review) { FactoryBot.create(:review, user: user) }

    context '投稿者本人がログインしている時' do
      before do
        # トップページを開く
        visit root_path
        # ゲストログインボタンをクリック
        find('a[class="guest-login-btn"]').click
        # トップページ上部に「ログインしました」と表示される
        expect(page).to have_content('ログインしました')
        # 新規登録画面へ移動する。
        visit new_review_path
        # レビューを投稿する
        attach_file 'review[image]', "#{Rails.root}/spec/factories/sample.png"
        fill_in 'product-name', with: 'テナジー（編集テスト）'
        select 'バタフライ', from: 'review[manufacture_id]'
        select '裏ソフトラバー', from: 'review[type_id]'
        select '硬い（ハード）', from: 'review[hardness_id]'
        select '10', from: 'review[spin_id]'
        select '10', from: 'review[speed_id]'
        select '10', from: 'review[control_id]'
        fill_in 'product-price', with: '8000'
        select '10', from: 'review[evaluation_id]'
        fill_in 'product-info', with: '素晴らしいラバーです。'
        find('input[name="commit"]').click
        # トップページに戻る
        visit root_path
        # 投稿したレビューの詳細画面に行く
        click_on 'テナジー（編集テスト）'
        find('a[class="edit-btn"]').click
      end

      it '「編集する」ボタンをクリックすれば、レビュー編集画面に移動できること' do
        expect(page).to have_content '- レビュー内容の編集 -'
      end

      it '全ての項目において、レビューの編集を行うことができること' do
        # 画像を選択
        attach_file 'review[image]', "#{Rails.root}/spec/factories/sample2.jpg"
        # 商品名を入力
        fill_in 'product-name', with: review.name
        # メーカーを選択
        select 'TSP', from: 'review[manufacture_id]'
        # ラバーの種類を選択
        select 'ラージ用ラバー', from: 'review[type_id]'
        # 打球感を選択
        select 'やや硬い（セミハード）', from: 'review[hardness_id]'
        # スピンを選択
        select '8', from: 'review[spin_id]'
        # スピ-ドを選択
        select '7', from: 'review[speed_id]'
        # コントロールを選択
        select '6', from: 'review[control_id]'
        # 商品の価格を入力
        fill_in 'product-price', with: review.price
        # 総合評価の選択
        select '5', from: 'review[evaluation_id]'
        # その他コメントの入力
        fill_in 'product-info', with: review.content
        #  動画を選択
        attach_file 'review[video]', "#{Rails.root}/spec/factories/test_movie.mp4"
        # 「レビューを編集する」ボタンをクリック
        find('input[name="commit"]').click

        # 編集内容が反映されていること
        # レビューの画像が表示されていること
        expect(page).to have_css("img[src*='sample2.jpg']")
        # 商品名が表示されていることを確認
        expect(page).to have_content review.name
        # メーカー名が表示されていることを確認
        expect(page).to have_content 'TSP'
        # ラバーの種類が表示されていることを確認
        expect(page).to have_content 'ラージ用ラバー'
        # 打球感が表示されていることを確認
        expect(page).to have_content 'やや硬い（セミハード）'
        # 価格が表示されていることを確認
        expect(page).to have_content review.price
        # スピン性能に関する点数が表示されていることを確認
        expect(page).to have_content '8'
        # スピード性能に関する点数が表示されていることを確認
        expect(page).to have_content '7'
        # コントロール性能に関する点数が表示されていることを確認
        expect(page).to have_content '6'
        # 総合評価点数が表示されていることを確認
        expect(page).to have_content '5'
        # その他コメントが表示されていることを確認
        expect(page).to have_content review.content
      end

      context '誤った値を入力すれば' do
        it 'レビューを投稿できず、エラーメッセージが表示されること' do
          # 商品名が空欄
          fill_in 'product-name', with: ''
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
          # その他コメントが空欄
          fill_in 'product-info', with: ''
          # レビューを投稿するボタンをクリックする（画像、商品名、その他コメントは空欄）
          find('input[name="commit"]').click

          # エラーメッセージが表示される
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
      end
    end

    context '投稿者以外のユーザーがログインしている時' do
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

      it '編集ボタンは表示されていないこと' do
        expect(page).not_to have_content('編集する')
      end
    end
  end

  describe 'レビュー削除機能' do
    context '投稿者本人がログインしている時' do
      before do
        # トップページを開く
        visit root_path
        # ゲストログインボタンをクリック
        find('a[class="guest-login-btn"]').click
        # トップページ上部に「ログインしました」と表示される
        expect(page).to have_content('ログインしました')
        # 新規登録画面へ移動する。
        visit new_review_path
        # レビューを投稿する
        attach_file 'review[image]', "#{Rails.root}/spec/factories/sample.png"
        fill_in 'product-name', with: 'テナジー（削除テスト）'
        select 'バタフライ', from: 'review[manufacture_id]'
        select '裏ソフトラバー', from: 'review[type_id]'
        select '硬い（ハード）', from: 'review[hardness_id]'
        select '10', from: 'review[spin_id]'
        select '10', from: 'review[speed_id]'
        select '10', from: 'review[control_id]'
        fill_in 'product-price', with: '8000'
        select '10', from: 'review[evaluation_id]'
        fill_in 'product-info', with: '素晴らしいラバーです。'
        find('input[name="commit"]').click
        # トップページに戻る
        visit root_path
        # 投稿したレビューの詳細画面に行く
        click_on 'テナジー（削除テスト）'
      end

      it '「削除する」ボタンをクリックすれば、レビューを削除できること' do
        find('a[class="delete-btn"]').click
        expect {
          # モーダルが表示される
          expect(page.accept_confirm).to eq 'レビューを完全に削除してもよろしいですか？'
          # 削除完了画面に移動し、「削除が完了しました」という文字列が表示されている
          expect(page).to have_content('削除が完了しました')
          # トップページに戻るボタンが表示されている
          expect(page).to have_css '.back-button'
        }.to change { Review.count }.by(-1)
      end

      it '削除完了画面で「トップページに戻るボタン」をクリックすれば、トップページに移動できること' do
        find('a[class="delete-btn"]').click
        # モーダルが表示される
        expect(page.accept_confirm).to eq 'レビューを完全に削除してもよろしいですか？'
        # 「トップページに戻る」ボタンをクリック
        find('a[class="back-button"]').click
        # トップページに移動している
        expect(current_path).to eq root_path
      end
    end

    context '投稿者以外のユーザーがログインしている時' do
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

      it '削除するボタンは表示されていないこと' do
        expect(page).not_to have_content('削除する')
      end
    end
  end
end
