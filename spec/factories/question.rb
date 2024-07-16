FactoryBot.define do
  factory :question do
    trait :question_1 do
      question_title { 'いつもの手足の冷える状態は？' }
    end

    trait :question_2 do
      question_title { 'いつもの汗のかき方は？' }
    end

    trait :question_3 do
      question_title { 'いつもの食事の量は？' }
    end

    trait :question_4 do
      question_title { '寒い場所にいるとき、どこに一番冷えを感じる？' }
    end

    trait :question_5 do
      question_title { '冷えたときに起こりやすい症状は？' }
    end

    trait :question_6 do
      question_title { 'わきで測る体温は？' }
    end
  end
end
