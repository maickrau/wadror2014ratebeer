FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :brewery do
    name "panimo"
    year 2000
  end

  factory :beer do
    name "kalia"
    brewery
    old_style "Lager"
  end
end