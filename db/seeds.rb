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
  Question.create!([
    {
      question_title: "いつもの手足の冷える状態は？",
      question_body: "手と足が冷える"
    },
    {
      question_title: "いつもの手足の冷える状態は？",
      question_body: "足は冷えるが手は温かい"
    },
    {
      question_title: "いつもの手足の冷える状態は？",
      question_body: "手も足もどちらも温かい"
    },
    {
      question_title: "いつもの汗のかき方は？",
      question_body: "汗はあまりかかない"
    },
    {
      question_title: "いつもの汗のかき方は？",
      question_body: "上半身に汗をかきやすい"
    },
    {
      question_title: "いつもの汗のかき方は？",
      question_body: "全身に汗をかきやすく、冷えやすい"
    },
    {
      question_title: "いつもの食事の量は？",
      question_body: "少なめだと思う"
    },
    {
      question_title: "いつもの食事の量は？",
      question_body: "普通だと思う"
    },
    {
      question_title: "いつもの食事の量は？",
      question_body: "多めだと思う"
    },
    {
      question_title: "寒い場所にいるとき、どこに一番冷えを感じる？",
      question_body: "手足の指先"
    },
    {
      question_title: "寒い場所にいるとき、どこに一番冷えを感じる？",
      question_body: "足先やふくらはぎ"
    },
    {
      question_title: "寒い場所にいるとき、どこに一番冷えを感じる？",
      question_body: "下腹部や二の腕"
    },
    {
      question_title: "冷えたときに起こりやすい症状は？",
      question_body: "頭痛や不眠"
    },
    {
      question_title: "冷えたときに起こりやすい症状は？",
      question_body: "顔のほてり"
    },
    {
      question_title: "冷えたときに起こりやすい症状は？",
      question_body: "お腹の張りやガス貯留"
    },
    {
      question_title: "わきで測る体温は？",
      question_body: "36.2℃より高い"
    },
    {
      question_title: "わきで測る体温は？",
      question_body: "36.2℃以下"
    }
  ])
