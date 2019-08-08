require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do

  it "アカウント作成のテストと作成時にログインできているかどうか" do
    visit new_user_path
    fill_in 'ユーザーネーム', with: '鈴木四郎'
    fill_in 'email', with: 'suzuki@gmail.com'
    fill_in 'パスワード', with: 'aaaaaa'
    fill_in '確認用パスワード', with: 'aaaaaa'
    click_on '登録する'
    expect(page).to have_content '鈴木四郎'
    expect(page).to have_content 'suzuki@gmail.com'
    expect(page).to have_content 'ログアウト'
  end

  it "ログインしていないのにタスクのページに飛ぼうとした場合エラーが出るかどうか" do
    visit blogs_path
    expect(page).to have_content 'ログイン'
  end

  it "自分が作成したタスクだけを表示しているかどうかのテストとログイン機能の実装テスト" do
    FactoryBot.create(:second_user)
    FactoryBot.create(:third_user)
    visit new_session_path
    fill_in 'Email', with: 'jirou@gmail.com'
    fill_in 'Password', with: 'bbbbbb'
    click_on 'Log in'
    expect(page).to have_content 'ログアウト'
    click_on 'タスク一覧へ'
    expect(page).to have_content 'あなたのタスクはありません'
    click_on 'タスクを作成する'
    fill_in 'ラベル名', with: '勉強'
    fill_in '詳細', with: 'rails'
    click_on '登録する'
    expect(page).to have_content '勉強'
    expect(page).to have_content 'rails'
    click_on 'ログアウト'
    fill_in 'Email', with: 'saburou@gmail.com'
    fill_in 'Password', with: 'cccccc'
    click_on 'Log in'
    expect(page).to have_content 'ログアウト'
    click_on 'タスク一覧へ'
    expect(page).to have_content 'あなたのタスクはありません'
  end
end