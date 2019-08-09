require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do

  it "アドミンの一覧のテスト" do
    FactoryBot.create(:second_user)
    FactoryBot.create(:third_user)
    visit admin_users_path
    expect(page).to have_content '鈴木二郎'
    save_and_open_page
    expect(page).to have_content '鈴木三郎'
    expect(page).to have_content '管理画面'
  end

  it "アドミン管理者の作成と詳細のテスト" do
    visit admin_users_path
    expect(page).to have_content '管理画面'
    click_on 'アカウントを作成する'
    fill_in 'ユーザーネーム', with: '鈴木四郎'
    fill_in 'email', with: 'suzuki@gmail.com'
    fill_in 'パスワード', with: 'aaaaaa'
    fill_in '確認用パスワード', with: 'aaaaaa'
    click_on '登録する'
    visit admin_users_path
    expect(page).to have_content '管理画面'
    expect(page).to have_content '鈴木四郎'
    click_on '詳細'
    expect(page).to have_content '鈴木四郎'
    expect(page).to have_content 'suzuki@gmail.com'
  end
  #
  it "アドミン管理者がユーザーに対する編集、更新のテスト" do
    FactoryBot.create(:second_user)
    visit admin_users_path
    click_on '編集'
    fill_in 'パスワード', with: 'aaaaaa'
    fill_in '確認用パスワード', with: 'aaaaaa'
    click_on '更新する'
    expect(page).to have_content '更新しました'
  end
  #
  it "アドミン管理者がユーザーに対する削除のテスト" do
    FactoryBot.create(:second_user)
    visit admin_users_path
    click_on '削除'
    expect(page).to have_content '管理画面'
    expect(page).to_not have_content '鈴木二郎'
  end
end