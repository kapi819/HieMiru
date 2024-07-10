FactoryBot.define do
  factory :cold_symptom do
    association :user, factory: :user

    trait :type_0 do
      symptom_type { 0 }
      symptom_title { "手足の末端が冷える典型的なタイプの冷え性" }
      symptom_body { "ストレスによる自律神経の乱れ・運動不足による筋肉量の低下・過度なダイエットによる栄養不足を原因として、体の中で熱を充分に作ることができていないことが出来ない状態です。" }
      solution { "肉や卵等のタンパク質の積極的な摂取" }
      image_url { "coldsymptom00.png" }
    end

    trait :type_1 do
      symptom_type { 1 }
      symptom_title { "体の内部（内臓）が冷えるタイプの冷え性" }
      symptom_body { "胃腸が弱い・暴飲暴食・ストレスで胃腸が弱っていることを原因として、体の中で熱を充分に作ることができていないことが出来ない状態です。" }
      solution { "自分のペースでできる運動（ランニング、ウォーキング）" }
      image_url { "coldsymptom01.png" }
    end

    trait :type_2 do
      symptom_type { 2 }
      symptom_title { "主に下半身が冷えるタイプの冷え性" }
      symptom_body { "座っている時間が長い・骨盤の歪み・過度なストレスを原因として、下半身の血行が悪化し、代謝が悪くなっている状態です。" }
      solution { "大股でしっかり歩くことを意識したウォーキング" }
      image_url { "coldsymptom02.png" }
    end

    trait :type_3 do
      symptom_type { 3 }
      symptom_title { "常に低体温で1年中寒さを感じるタイプの冷え性" }
      symptom_body { "乱れた生活リズム・寝不足や過労・過度なストレスを原因として、体全体の機能が低下し、体の中で熱を充分に作ることができていないことが出来ない状態です。" }
      solution { "11時までの睡眠による生活習慣の改善" }
      image_url { "coldsymptom03.png" }
    end
  end
end