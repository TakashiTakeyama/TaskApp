# 「FactoryBotを使用します」という記述
FactoryBot.define do

  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :blog do
    name { '仕事' }
    details { '打ち合わせ' }
  end

  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_blog, class: Blog do
    name { '育児' }
    details { '送り迎え' }
  end

  factory :third_blog, class: Blog do
    name { '勉強'}
    details { 'Ruby on Rails '}
  end
end