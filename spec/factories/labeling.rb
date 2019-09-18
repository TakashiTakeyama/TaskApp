FactoryBot.define do
  factory :second_labeling, class: Labeling do
    blog_id { Blog.first.id }
    label_id { Label.first.id }
  end

  factory :third_labeling, class: Labeling do
    blog_id { 2 }
    label_id { 2 }
  end
end