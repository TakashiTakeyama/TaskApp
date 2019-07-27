require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
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
    fill_in 'Name', with: 'タスク名'
    fill_in 'Details', with: 'タスク詳細'
    click_on 'Create Blog'
    expect(page).to have_content 'タスク名'
    expect(page).to have_content 'タスク詳細'
  end

  scenario "タスク詳細のテスト" do
    visit new_blog_path
    Blog.new
    fill_in 'Name', with: 'タスク名'
    fill_in 'Details', with: 'タスク詳細'
    click_on 'Create Blog'
    visit blogsrails _path(Blog.last.id)
    expect(page).to have_content 'タスク名'
    expect(page).to have_content 'タスク詳細'
  end
end