require 'rails_helper'

RSpec.describe Blog, type: :model do

  it "nameが空ならバリデーションが通らない" do
    task = Blog.new(name: '', details: '失敗テスト')
    expect(task).not_to be_valid
  end

  it "detailsが空ならバリデーションが通らない" do
    task = Blog.new(name: '失敗テスト', details: '')
    expect(task).not_to be_valid
  end

  it "name,details両方が空ならバリデーションが通らない" do
    task = Blog.new(name: '', details: '')
    expect(task).not_to be_valid
  end
end
