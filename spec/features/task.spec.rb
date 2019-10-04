require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    # FactoryBot.create(:blog)
    # FactoryBot.create(:second_blog)
    # FactoryBot.create(:third_blog)
  end

  scenario "タスク一覧のテスト" do
    FactoryBot.create(:second_user)
    Blog.create!(name: 'test_task_01', details: 'testtesttest', user_id: User.first.id )
    Blog.create!(name: 'test_task_02', details: 'samplesample', user_id: User.first.id )
    visit new_session_path
    fill_in 'session_email', with: 'jirou@gmail.com'
    fill_in 'Password', with: 'bbbbbb'
    click_on 'Log in'

    visit blogs_path
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content 'samplesample'
  end

  it "タスク作成のテスト" do
    FactoryBot.create(:second_user)
    visit new_session_path
    fill_in 'session_email', with: 'jirou@gmail.com'
    fill_in 'Password', with: 'bbbbbb'
    click_on 'Log in'
    visit new_blog_path
    fill_in 'タスク名', with: 'タスク名'
    fill_in '詳細', with: 'タスク詳細'
    click_on '登録する'
    expect(page).to have_content 'タスク名'
    expect(page).to have_content 'タスク詳細'
  end

  scenario "タスク詳細のテスト" do
    FactoryBot.create(:second_user)
    visit new_session_path
    fill_in 'session_email', with: 'jirou@gmail.com'
    fill_in 'Password', with: 'bbbbbb'
    click_on 'Log in'
    visit new_blog_path
    fill_in 'タスク名', with: 'タスク名'
    fill_in '詳細', with: 'タスク詳細'
    click_on '登録する'
    visit blogs_path(Blog.last.id)
    expect(page).to have_content 'タスク名'
    expect(page).to have_content 'タスク詳細'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    FactoryBot.create(:second_user)
    Blog.create!(name: 'test_task_01', details: 'testtesttest', user_id: User.first.id )
    Blog.create!(name: 'test_task_02', details: 'samplesample', user_id: User.first.id )
    Blog.create!(name: 'test_task_03', details: 'tesamtesamte', user_id: User.first.id )
    visit new_session_path
    fill_in 'session_email', with: 'jirou@gmail.com'
    fill_in 'Password', with: 'bbbbbb'
    click_on 'Log in'
    visit blogs_path
    all_table_row = page.all('tr')
    expect(all_table_row[1]).to have_content 'testtesttest'
    expect(all_table_row[2]).to have_content 'samplesample'
    expect(all_table_row[3]).to have_content 'tesamtesamte'
  end

  it "タスクが終了期限順に表示されるテスト" do
    FactoryBot.create(:second_user)
    Blog.create!(name: 'test_task_01', details: 'testtesttest', expired_at: Time.now, user_id: User.first.id)
    Blog.create!(name: 'test_task_02', details: 'samplesample', expired_at: Time.now + 1.hour, user_id: User.first.id)
    Blog.create!(name: 'test_task_03', details: 'testtesttest', expired_at: Time.now + 2.hour, user_id: User.first.id)
    Blog.create!(name: 'test_task_04', details: 'samplesample', expired_at: Time.now + 3.hour, user_id: User.first.id)
    visit new_session_path
    fill_in 'session_email', with: 'jirou@gmail.com'
    fill_in 'Password', with: 'bbbbbb'
    click_on 'Log in'
    visit blogs_path
    click_on '終了期限でソートする'
    all_table_row = page.all('tr')
    expect(all_table_row[1]).to have_content 'test_task_04'
    expect(all_table_row[2]).to have_content 'test_task_03'
    expect(all_table_row[3]).to have_content 'test_task_02'
    expect(all_table_row[4]).to have_content 'test_task_01'
  end

  it "検索が機能しているかのテスト" do
    FactoryBot.create(:second_user)
    Blog.create!(name: 'test_task_01', details: '勉強', expired_at: Time.now, state: '着手中', user_id: User.first.id)
    Blog.create!(name: 'test_task_02', details: '料理', expired_at: Time.now + 1.hour, user_id: User.first.id)
    Blog.create!(name: 'test_task_03', details: '育児', expired_at: Time.now + 2.hour, user_id: User.first.id)
    visit new_session_path
    fill_in 'session_email', with: 'jirou@gmail.com'
    fill_in 'Password', with: 'bbbbbb'
    click_on 'Log in'
    visit blogs_path
    fill_in 'search_field_name', with: 'test_task_01'
    click_on '検索する'
    expect(page).to have_content '勉強'
    expect(page).to_not have_content '料理'
    expect(page).to_not have_content '育児'
    click_link '全件一覧'
    select '着手中', from: 'q_state_eq'
    click_on '検索する'
    expect(page).to have_content '勉強'
    expect(page).to_not have_content '料理'
    expect(page).to_not have_content '育児'
    click_link '全件一覧'
    fill_in 'search_field_name', with: '仕事'
    select '未着手', from: 'q_state_eq'
    click_on '検索する'
    expect(page).to_not have_content '仕事'
    expect(page).to_not have_content '育児'
  end

  it "優先度で並んでいるかのテスト" do
    FactoryBot.create(:second_user)
    Blog.create!(name: '仕事', details: 'testtesttest', priority: '低', expired_at: Time.now, user_id: User.first.id)
    Blog.create!(name: '育児', details: 'samplesample', priority: '中', expired_at: Time.now + 1.hour, user_id: User.first.id)
    Blog.create!(name: '勉強', details: 'testtesttest', priority: '高', expired_at: Time.now + 2.hour, user_id: User.first.id)
    visit new_session_path
    fill_in 'session_email', with: 'jirou@gmail.com'
    fill_in 'Password', with: 'bbbbbb'
    click_on 'Log in'
    visit blogs_path
    all_table_row = page.all('tr')
    expect(all_table_row[1]).to have_content '仕事'
    expect(all_table_row[2]).to have_content '育児'
    expect(all_table_row[3]).to have_content '勉強'
    click_link '優先度でソートする'
    # save_and_open_page
    all_table_row = page.all('tr')
    expect(all_table_row[1]).to have_content '勉強'
    expect(all_table_row[2]).to have_content '育児'
    expect(all_table_row[3]).to have_content '仕事'
  end

  it "タスクに複数のラベルを複数つけられる事の確認テスト" do
    FactoryBot.create(:second_user)
    FactoryBot.create(:second_label)
    FactoryBot.create(:third_label)
    FactoryBot.create(:forth_label)
    visit new_session_path
    fill_in 'session_email', with: 'jirou@gmail.com'
    fill_in 'Password', with: 'bbbbbb'
    click_on 'Log in'
    click_on 'タスクを作成する'
    fill_in 'タスク名', with: 'タスク名1'
    fill_in '詳細', with: 'タスク詳細1'
    check 'blog_label_ids_1'
    check 'blog_label_ids_2'
    check 'blog_label_ids_3'
    click_on '登録する'
    click_on '戻る'
    all_table_row = page.all('tr')
    expect(all_table_row[1]).to have_content 'test1'
    expect(all_table_row[1]).to have_content 'test2'
    expect(all_table_row[1]).to have_content 'test3'
  end

  it "ラベルで検索機能の動作確認テスト" do
    FactoryBot.create(:second_user)
    FactoryBot.create(:second_label)
    FactoryBot.create(:third_label)
    visit new_session_path
    fill_in 'session_email', with: 'jirou@gmail.com'
    fill_in 'Password', with: 'bbbbbb'
    click_on 'Log in'
    click_on 'タスクを作成する'
    fill_in 'タスク名', with: 'タスク名1'
    fill_in '詳細', with: 'タスク詳細1'
    check 'blog_label_ids_4'
    click_on '登録する'
    click_on '戻る'
    click_on 'タスクを作成する'
    fill_in 'タスク名', with: 'タスク名2'
    fill_in '詳細', with: 'タスク詳細2'
    check 'blog_label_ids_5'
    click_on '登録する'
    visit  blogs_path
    all_table_row = page.all('tr')
    expect(all_table_row[1]).to have_content 'test1'
    select 'test2', from: 'q_labels_label_name_eq'
    click_on '検索する'
    all_table_row = page.all('tr')
    expect(all_table_row[1]).to have_content 'test2'
  end
end


