FactoryBot.define do
  factory :choice do
    question

    trait :choice_1_1 do
      question_body { '手と足が冷える' }
      question_type { 0 }
    end

    trait :choice_1_2 do
      question_body { '足は冷えるが手は温かい' }
      question_type { 1 }
    end

    trait :choice_1_3 do
      question_body { '手も足もどちらも温かい' }
      question_type { 2 }
    end

    trait :choice_2_1 do
      question_body { '汗はあまりかかない' }
      question_type { 0 }
    end

    trait :choice_2_2 do
      question_body { '上半身に汗をかきやすい' }
      question_type { 1 }
    end

    trait :choice_2_3 do
      question_body { '全身に汗をかきやすく、冷えやすい' }
      question_type { 2 }
    end

    trait :choice_3_1 do
      question_body { '少なめだと思う' }
      question_type { 0 }
    end

    trait :choice_3_2 do
      question_body { '普通だと思う' }
      question_type { 1 }
    end

    trait :choice_3_3 do
      question_body { '多めだと思う' }
      question_type { 2 }
    end

    trait :choice_4_1 do
      question_body { '手足の指先' }
      question_type { 0 }
    end

    trait :choice_4_2 do
      question_body { '足先やふくらはぎ' }
      question_type { 1 }
    end

    trait :choice_4_3 do
      question_body { '下腹部や二の腕' }
      question_type { 2 }
    end

    trait :choice_5_1 do
      question_body { '頭痛や不眠' }
      question_type { 0 }
    end

    trait :choice_5_2 do
      question_body { '顔のほてり' }
      question_type { 1 }
    end

    trait :choice_5_3 do
      question_body { 'お腹の張りやガス貯留' }
      question_type { 2 }
    end

    trait :choice_6_1 do
      question_body { '36.2℃より高い' }
      question_type { 0 }
    end

    trait :choice_6_2 do
      question_body { '36.2℃以下' }
      question_type { 1 }
    end
  end
end
