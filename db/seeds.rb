# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 診断の質問文を作成
questions_and_choices = [
  {
    question_title: 'いつもの手足の冷える状態は？',
    choices: [
      { choice_text: '手と足が冷える', value: 1 },
      { choice_text: '足は冷えるが手は温かい', value: 2 },
      { choice_text: '手も足もどちらも温かい', value: 3 }
    ]
  },
  {
    question_title: 'いつもの汗のかき方は？',
    choices: [
      { choice_text: '汗はあまりかかない', value: 1 },
      { choice_text: '上半身に汗をかきやすい', value: 2 },
      { choice_text: '全身に汗をかきやすく、冷えやすい', value: 3 }
    ]
  },
  {
    question_title: 'いつもの食事の量は？',
    choices: [
      { choice_text: '少なめだと思う', value: 1 },
      { choice_text: '普通だと思う', value: 2 },
      { choice_text: '多めだと思う', value: 3 }
    ]
  },
  {
    question_title: '寒い場所にいるとき、どこに一番冷えを感じる？',
    choices: [
      { choice_text: '手足の指先', value: 1 },
      { choice_text: '足先やふくらはぎ', value: 2 },
      { choice_text: '下腹部や二の腕', value: 3 }
    ]
  },
  {
    question_title: '冷えたときに起こりやすい症状は？',
    choices: [
      { choice_text: '頭痛や不眠', value: 1 },
      { choice_text: '顔のほてり', value: 2 },
      { choice_text: 'お腹の張りやガス貯留', value: 3 }
    ]
  },
  {
    question_title: 'わきで測る体温は？',
    choices: [
      { choice_text: '36.2℃より高い', value: 1 },
      { choice_text: '36.2℃以下', value: 2 }
    ]
  }
]

questions_and_choices.each do |q|
  question = Question.create!(question_title: q[:question_title])
  q[:choices].each do |choice|
    Choice.create!(question: question, choice_text: choice[:choice_text], value: choice[:value])
  end
end
