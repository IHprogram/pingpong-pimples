require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { FactoryBot.create(:user) }

  scenario "新規登録を行う" do
    # トップページを開く
    visit root_path
    find('div[class="menu-wrapper"]').click
    # メニューボタンをクリックすると、新規登録ボタンがある。
    expect(page).to have_content('新規登録')
    find('a[class="login"]').click
    # 新規登録画面へ移動する。
    visit new_user_registration_path
    # ニックネームを入力
    fill_in 'nickname', with: user.nickname
    # メールアドレスを入力
    fill_in 'メールアドレス', with: "wertyuioskdhf@example.com"
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
