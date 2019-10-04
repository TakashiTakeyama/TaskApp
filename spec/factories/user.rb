FactoryBot.define do

  factory :first_user do
    name { '鈴木一郎' }
    email { 'itirou@gamil.con' }
    password { 'aaaaaa' }
    password_confirmation { 'aaaaaa' }
  end

  factory :second_user, class: User do
    name { '鈴木二郎' }
    email { 'jirou@gmail.com' }
    password { 'bbbbbb' }
    password_confirmation { 'bbbbbb' }
  end

  factory :third_user, class: User do
    name { '鈴木三郎'}
    email { 'saburou@gmail.com'}
    password { 'cccccc' }
    password_confirmation { 'cccccc' }
  end
end