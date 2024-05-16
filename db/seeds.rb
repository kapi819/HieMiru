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
questions = Question.create!([
  { question_title: "いつもの手足の冷える状態は？" },
  { question_title: "いつもの汗のかき方は？" },
  { question_title: "いつもの食事の量は？" },
  { question_title: "寒い場所にいるとき、どこに一番冷えを感じる？" },
  { question_title: "冷えたときに起こりやすい症状は？" },
  { question_title: "わきで測る体温は？" }
])

Choice.create!([
  { question_body: "手と足が冷える", question_type: 0, question_id: questions[0].id },
  { question_body: "足は冷えるが手は温かい", question_type: 1, question_id: questions[0].id },
  { question_body: "手も足もどちらも温かい", question_type: 2, question_id: questions[0].id },
  { question_body: "汗はあまりかかない", question_type: 0, question_id: questions[1].id },
  { question_body: "上半身に汗をかきやすい", question_type: 1, question_id: questions[1].id },
  { question_body: "全身に汗をかきやすく、冷えやすい", question_type: 2, question_id: questions[1].id },
  { question_body: "少なめだと思う", question_type: 0, question_id: questions[2].id },
  { question_body: "普通だと思う", question_type: 1, question_id: questions[2].id },
  { question_body: "多めだと思う", question_type: 2, question_id: questions[2].id },
  { question_body: "手足の指先", question_type: 0, question_id: questions[3].id },
  { question_body: "足先やふくらはぎ", question_type: 1, question_id: questions[3].id },
  { question_body: "下腹部や二の腕", question_type: 2, question_id: questions[3].id },
  { question_body: "頭痛や不眠", question_type: 0, question_id: questions[4].id },
  { question_body: "顔のほてり", question_type: 1, question_id: questions[4].id },
  { question_body: "お腹の張りやガス貯留", question_type: 2, question_id: questions[4].id },
  { question_body: "36.2℃より高い", question_type: 0, question_id: questions[5].id },
  { question_body: "36.2℃以下", question_type: 1, question_id: questions[5].id },
])

# ユーザーの作成
user1 = User.find_or_create_by!(
  name: "John Doe",
  email: "john.doe@example.com",
  password: "password",
  password_confirmation: "password"
)

user2 = User.find_or_create_by!(
  name: "Jane Smith",
  email: "jane.smith@example.com",
  password: "password",
  password_confirmation: "password"
)

#診断の症状を作成
ColdSymptom.create!([
  { symptom_type: 0,
    symptom_title: "手足の末端が冷える典型的なタイプの冷え性",
    symptom_body: "ストレスによる自律神経の乱れ・運動不足による筋肉量の低下・過度なダイエットによる栄養不足を原因として、体の中で熱を充分に作ることができていないことが出来ない状態です。",
    solution: "肉や卵等のタンパク質の積極的な摂取",
    image_url: "coldsymptom00.png",
    user: user1},
  { symptom_type: 1,
    symptom_title: "体の内部（内臓）が冷えるタイプの冷え性",
    symptom_body: "胃腸が弱い・暴飲暴食・ストレスで胃腸が弱っていることを原因として、体の中で熱を充分に作ることができていないことが出来ない状態です。", 
    solution: "自分のペースでできる運動（ランニング、ウォーキング）",
    image_url: "coldsymptom01.png",
    user: user1},
  { symptom_type: 2,
    symptom_title: "主に下半身が冷えるタイプの冷え性",
    symptom_body: "座っている時間が長い・骨盤の歪み・過度なストレスを原因として、下半身の血行が悪化し、代謝が悪くなっている状態です。", 
    solution: "大股でしっかり歩くことを意識したウォーキング",
    image_url: "coldsymptom02.png",
    user: user2},
  { symptom_type: 3,
    symptom_title: "常に低体温で1年中寒さを感じるタイプの冷え性",
    symptom_body: "乱れた生活リズム・寝不足や過労・過度なストレスを原因として、体全体の機能が低下し、体の中で熱を充分に作ることができていないことが出来ない状態です。", 
    solution: "11時までの睡眠による生活習慣の改善",
    image_url: "coldsymptom03.png",
    user: user2},
])
