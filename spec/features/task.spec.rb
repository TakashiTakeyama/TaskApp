require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    FactoryBot.create(:blog)
    FactoryBot.create(:second_blog)
    FactoryBot.create(:third_blog)
  end

  # scenario "タスク一覧のテスト" do
  #   Blog.create!(name: 'test_task_01', details: 'testtesttest')
  #   Blog.create!(name: 'test_task_02', details: 'samplesample')
  #
  #   visit blogs_path
  #   # save_and_open_page
  #   expect(page).to have_content 'testtesttest'
  #   expect(page).to have_content ''
  # end
  #
  # it "タスク作成のテスト" do
  #   visit new_blog_path
  #   Blog.new
  #   fill_in 'タスク名', with: 'タスク名'
  #   fill_in '詳細', with: 'タスク詳細'
  #   click_on '登録する'
  #   expect(page).to have_content 'タスク名'
  #   expect(page).to have_content 'タスク詳細'
  # end
  #
  # scenario "タスク詳細のテスト" do
  #   visit new_blog_path
  #   Blog.new
  #   fill_in 'タスク名', with: 'タスク名'
  #   fill_in '詳細', with: 'タスク詳細'
  #   click_on '登録する'
  #   visit blogs_path(Blog.last.id)
  #   expect(page).to have_content 'タスク名'
  #   expect(page).to have_content 'タスク詳細'
  # end
  #
  # scenario "タスクが作成日時の降順に並んでいるかのテスト" do
  #   visit blogs_path
  #   all_table_row = page.all('tr')
  #   expect(all_table_row[1]).to have_content '仕事'
  #   expect(all_table_row[2]).to have_content '育児'
  #   expect(all_table_row[3]).to have_content '勉強'
  # end

  # it "タスクが終了期限順に表示されるテスト" do
  #   Blog.create!(name: 'test_task_01', details: 'testtesttest', expired_at: Time.now)
  #   Blog.create!(name: 'test_task_02', details: 'samplesample', expired_at: Time.now + 1.hour)
  #   Blog.create!(name: 'test_task_03', details: 'testtesttest', expired_at: Time.now + 2.hour)
  #   Blog.create!(name: 'test_task_04', details: 'samplesample', expired_at: Time.now + 3.hour)
  #   visit blogs_path
  #   click_on '終了期限でソートする'
  #   all_table_row = page.all('tr')
  #   expect(all_table_row[1]).to have_content 'test_task_04'
  #   expect(all_table_row[2]).to have_content 'test_task_03'
  #   expect(all_table_row[3]).to have_content 'test_task_02'
  #   expect(all_table_row[4]).to have_content 'test_task_01'
  # end

  it "検索が機能しているかのテスト" do
    visit blogs_path
    fill_in 'search_field_name', with: '仕事'
    click_on '検索する'
    expect(page).to have_content '仕事'
    expect(page).to_not have_content '育児'
    expect(page).to_not have_content '勉強'
    visit blogs_path
    fill_in 'search_field_details', with: '打ち合わせ'
    click_on '検索する'
    expect(page).to have_content '打ち合わせ'
    expect(page).to_not have_content '送り迎え'
    expect(page).to_not have_content 'Ruby on Rails'
  end
end

