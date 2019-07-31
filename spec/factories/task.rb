FactoryBot.define do

  factory :blog do
    name { '仕事' }
    details { '打ち合わせ' }
    state { '着手中' }
    priority { '低' }
  end

  factory :second_blog, class: Blog do
    name { '育児' }
    details { '送り迎え' }
    state { '未着手' }
    priority { '中' }
  end

  factory :third_blog, class: Blog do
    name { '勉強'}
    details { 'Ruby on Rails '}
    state { '完了' }
    priority { '高' }
  end
end