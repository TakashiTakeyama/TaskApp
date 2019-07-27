require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    FactoryBot.create(:blog)
    FactoryBot.create(:second_blog)
    FactoryBot.create(:third_blog)
  end

  scenario "タスク一覧のテスト" do
    Blog.create!(name: 'test_task_01', details: 'testtesttest')
    Blog.create!(name: 'test_task_02', details: 'samplesample')

    visit blogs_path
    save_and_open_page
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content ''
  end

  it "タスク作成のテスト" do
    visit new_blog_path
    Blog.new
    fill_in 'タスク名', with: 'タスク名'
    fill_in '詳細', with: 'タスク詳細'
    click_on '登録する'
    expect(page).to have_content 'タスク名'
    expect(page).to have_content 'タスク詳細'
  end

  scenario "タスク詳細のテスト" do
    visit new_blog_path
    Blog.new
    fill_in 'タスク名', with: 'タスク名'
    fill_in '詳細', with: 'タスク詳細'
    click_on '登録する'
    visit blogs_path(Blog.last.id)
    expect(page).to have_content 'タスク名'
    expect(page).to have_content 'タスク詳細'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit blogs_path
    trs = page.all('tr')
    expect(trs[3]).to have_content '仕事'
    expect(trs[2]).to have_content '育児'
    expect(trs[1]).to have_content '勉強'
  end
end

