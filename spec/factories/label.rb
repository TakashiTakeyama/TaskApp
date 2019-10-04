FactoryBot.define do

  factory :second_label, class: Label do
    label_name { 'test1' }

  end

  factory :third_label, class: Label do
    label_name { 'test2' }
  end

  factory :forth_label, class: Label do
    label_name { 'test3' }
  end
end