require 'rails_helper'

RSpec.describe "Users", type: :system do

  describe "新規登録を行う時" do
    context "正しい値を入力すれば" do
      let!(:user) { FactoryBot.build(:user) }
      scenario "新規登録が成功すること" do
        # トップページを開く
        visit root_path
        find('div[class="menu-wrapper"]').click
        # メニューボタンをクリックすると、新規登録ボタンがある
        expect(page).to have_content('新規登録')
        find('a[class="sign-up"]').click
        # 新規登録画面へ移動する。
        visit new_user_registration_path
        # ニックネームを入力
        fill_in 'nickname', with: user.nickname
        # メールアドレスを入力
        fill_in 'メールアドレス', with: user.email
        # パスワードを入力
        fill_in 'パスワード', with: user.password
        # 確認用パスワードを入力
        fill_in 'パスワード(再入力)', with: user.password_confirmation
        # 会員登録ボタンをクリックすると、ユーザーモデルのカウントが1上がる
        expect{
          find('input[name="commit"]').click
        }.to change{ User.count }.by(1)
      end
    end

    context "誤った値を入力すれば" do
      let!(:user) { FactoryBot.build(:user) }
      scenario "新規登録が失敗し、新規登録画面に戻ること" do
        # トップページを開く
        visit root_path
        find('div[class="menu-wrapper"]').click
        # メニューボタンをクリックすると、新規登録ボタンがある
        expect(page).to have_content('新規登録')
        find('a[class="sign-up"]').click
        # 新規登録画面へ移動する。
        visit new_user_registration_path
        # ニックネームを入力
        fill_in 'nickname', with: "nickname"
        # メールアドレスを入力
        fill_in 'メールアドレス', with: "email"
        # パスワードを入力
        fill_in 'パスワード', with: "password123"
        # 確認用パスワードを入力
        fill_in 'パスワード(再入力)', with: "password123"
        # 会員登録ボタンをクリックする
        find('input[name="commit"]').click
        # 新規登録画面にリダイレクトする
        expect(current_path).to eq new_user_registration_path
      end
    end
  end

  describe "ログインを行う時" do
    context "正しい値を入力すれば" do
      let!(:user) { FactoryBot.create(:user) }
      scenario "ログインに成功し、トップページに移動すること" do
        visit root_path
        find('div[class="menu-wrapper"]').click
        # メニューボタンをクリックすると、ログインボタンがある
        expect(page).to have_content('ログイン')
        find('a[class="login"]').click
        # ログイン仮面へ移動する
        visit new_user_session_path
        # メールアドレスを入力
        fill_in 'メールアドレス', with: user.email
        # パスワードを入力
        fill_in 'パスワード', with: user.password
        # ログインボタンをクリック
        find('input[name="commit"]').click
        # ログインに成功すれば、トップページに移動する
        expect(current_path).to eq root_path
      end
    end

    context "誤った値を入力すれば" do
      let!(:user) { FactoryBot.create(:user) }
      scenario "ログインが失敗し、ログイン画面に戻ること" do
        visit root_path
        find('div[class="menu-wrapper"]').click
        # メニューボタンをクリックすると、新規登録ボタンがある
        expect(page).to have_content('ログイン')
        find('a[class="login"]').click
        # ログイン仮面へ移動する
        visit new_user_session_path
        # メールアドレスを入力
        fill_in 'メールアドレス', with: "email"
        # パスワードを入力
        fill_in 'パスワード', with: "password123"
        # ログインボタンをクリック
        find('input[name="commit"]').click
        # 新規登録画面にリダイレクトする
        expect(current_path).to eq new_user_session_path
      end
    end

    context "メニューにあるゲストログインボタンをクリックすれば" do
      let!(:user) { FactoryBot.create(:user) }
      scenario "ログインに成功し、トップページに移動すること" do
        visit root_path
        find('div[class="menu-wrapper"]').click
        # メニューボタンをクリックすると、ゲストボタンがある
        expect(page).to have_content('ゲストログイン（閲覧用）')
        find('a[class="guest-login"]').click
        expect(current_path).to eq root_path
        # トップページ上部に「ログインしました」と表示される
        expect(page).to have_content('ログインしました')
      end
    end
  end

  describe "ログアウトを行う時" do
    context "正しい値を入力すれば" do
      let!(:user) { FactoryBot.create(:user) }
      scenario "ログアウトに成功し、トップページに移動すること" do
        visit root_path
        find('div[class="menu-wrapper"]').click
        # メニューボタンをクリックすると、ログインボタンがある
        find('a[class="login"]').click
        # ログイン仮面へ移動する
        visit new_user_session_path
        # メールアドレスを入力
        fill_in 'メールアドレス', with: user.email
        # パスワードを入力
        fill_in 'パスワード', with: user.password
        # ログインボタンをクリック
        find('input[name="commit"]').click
        # ログインに成功すれば、トップページに移動する
        expect(current_path).to eq root_path
        # ここまでがログイン
        # ここからがログアウト
        find('div[class="menu-wrapper"]').click
        # メニューボタンをクリックすると、ログアウトボタンがある
        expect(page).to have_content('ログアウト')
        find('a[class="logout"]').click
        # ログアウトボタンをクリックするとログアウトし、トップ画面に戻る
        expect(current_path).to eq root_path
        # トップページ上部に「ログアウトしました」と表示される
        expect(page).to have_content('ログアウトしました')
      end
    end
  end
end
