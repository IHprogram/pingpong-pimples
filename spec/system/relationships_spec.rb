require 'rails_helper'

RSpec.describe "Relationships", type: :system do
  describe 'フォロー機能' do
    context 'ユーザーがログインしていれば' do
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
        # 投稿者のプロフィールページへ移動
        find('a[class="user-profile-link"]').click
      end
      
      it "プロフィールページにフォローボタンが存在すること" do
        # フォローボタンが存在すること
        expect(page).to have_css '.follow-btn'
        expect(page).to have_content 'フォロー'
      end

      it "フォローボタンをクリックすれば、ユーザーをフォローできること" do
        # フォロワー数が「0」の状態
        expect(page).to have_content '0'
        expect {
          # フォローボタンをクリックすると、そのユーザーをフォローできる
          find('input[class="follow-btn"]').click
          # フォロー解除ボタンがある（「.unfollow-btn」というクラス名がある）
          expect(page).to have_css '.unfollow-btn'
        }.to change { Relationship.count }.by(1)
        # フォロワー数が「1」に増えている
        expect(page).to have_content '1'
      end

      it 'フォロー解除ボタンをクリックすれば、フォローを解除できること' do
        # まずは一度ユーザーをフォローする
        find('input[class="follow-btn"]').click
        # フォロワー数は「1」の状態
        expect(page).to have_content '1'
        # フォロー解除ボタンをクリック
        find('input[class="unfollow-btn"]').click
        expect {
          # モーダルが表示される
          expect(page.accept_confirm).to eq 'フォローを解除してもよろしいですか？'
          # フォローボタンに変わる
          expect(page).to have_css '.follow-btn'
        }.to change { Relationship.count }.by(-1)
        # フォロワー数が「0」に減っている
        expect(page).to have_content '0'
      end
    end
  end
end
