# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.find_or_create_by!(email: 'admin@email.com') do |admin|
  admin.password = 'aaaaaa'
  admin.password_confirmation = 'aaaaaa'
end

oliver = User.find_or_create_by!(email: "111@111") do |user|
  user.nickname = "オリバー"
  user.password = "111111"
  user.introduction = "最近始めました！ライブやフェスの参戦投稿がメインです！"
  user.user_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user_image1.jpg"), filename:"user_image1.jpg")
end

alicia = User.find_or_create_by!(email: "222@222") do |user|
  user.nickname = "アリシア"
  user.password = "222222"
  user.introduction = "演歌が好きで、まわりに共通の趣味の人がいなくて登録してみました。"
  user.user_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user_image2.jpg"), filename:"user_image2.jpg")
end

damiano = User.find_or_create_by!(email: "333@333") do |user|
  user.nickname = "ダミアーノ"
  user.password = "333333"
  user.introduction = "よろしくです。"
  user.user_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user_image3.jpg"), filename:"user_image3.jpg")
end

victoria = User.find_or_create_by!(email: "444@444") do |user|
  user.nickname = "ビクトリア"
  user.password = "444444"
  user.introduction = "大学で軽音サークルに入ってます♪新しいアーティスト探索中…"
  user.user_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user_image4.jpg"), filename:"user_image4.jpg")
end


# ジャンル登録 
genre_names = [
  "洋楽ROCKバンド",
  "邦楽ROCKバンド",
  "K-POP",
  "J-POP",
  "クラシック",
  "演歌",
  "ラップ",
  "アニソン",
  "インディーズバンド"
]

genre_names.each do |name|
  Genre.find_or_create_by!(name: name)
end

puts

# アーティスト登録
artists = [
  {
    name:      "The Night Strangers",
    introduction: "アメリカ出身のロックバンド。ヘヴィなギターサウンドと疾走感溢れるドラムで、ライブパフォーマンスの迫力が特徴。最新アルバム『Midnight Echoes』は、世界中で大ヒットを記録。",
    genre_name:   "洋楽ROCKバンド",
    artist_image:   "Vibin/db/fixtures/TheNightStrangers.jpg"
  },
  {
    name:      "Echo Rebels",
    introduction: "イギリスのロックバンドで、シューゲイザーとグランジの要素を取り入れた音楽が特徴。幻想的でエモーショナルな歌詞と共に、独特なギターリフを特徴とする。",
    genre_name:   "洋楽ROCKバンド",
    artist_image:  "Vibin/db/fixtures/EchoRebels.jpg"
  },
  {
    name:      "サクラメメント",
    introduction: "日本のロックバンド。疾走感のあるサウンドと、深い歌詞が特徴。日本国内で幅広いファン層を持ち、ライブ活動を活発に行っている。",
    genre_name:   "邦楽ROCKバンド",
    artist_image: "Vibin/db/fixtures/サクラメメント.jpg"
  },
  {
    name:      "雷鳴リフレイン",
    introduction: "変則的なリズムとエモーショナルな歌声が特徴的な日本のロックバンド。メンバー全員が作詞作曲を担当し、その独自の音楽性で注目を集めている。",
    genre_name:   "邦楽ROCKバンド",
    artist_image: "Vibin/db/fixtures/雷鳴リフレイン.jpg"
  },
  {
    name:      "StarBloom",
    introduction: "韓国の女性グループで、ポップとダンスミュージックを融合させたサウンドが特徴。キュートなルックスとパワフルなパフォーマンスで、国内外の音楽シーンで注目されている。",
    genre_name:   "K-POP",
    artist_image: "Vibin/db/fixtures/StarBloom.jpg"
  },
  {
    name:      "Neon Pulse",
    introduction: "韓国出身の男性グループ。エレクトロポップを基盤に、先鋭的なビジュアルと音楽でファンを魅了。グローバルに活動しており、英語圏のファンも多い。",
    genre_name:   "K-POP",
    artist_image: "Vibin/db/fixtures/Vibin_no_image.jpg"
  },
  {
    name:      "晴れた日の空",
    introduction: "日本のJ-POPグループ。爽やかなメロディと心温まる歌詞が特徴で、リリースしたシングルは数多くのランキングで上位に入るなど高評価を受けている。",
    genre_name:   "J-POP",
    artist_image: "Vibin/db/fixtures/Vibin_no_image.jpg"
  },
  {
    name:      "ピースフルドリーム",
    introduction: "J-POPの中でもアコースティックなサウンドが特徴的なグループ。ファンとの交流を大切にし、温かみのある歌詞とメロディが共感を呼んでいる。",
    genre_name:   "J-POP",
    artist_image: "Vibin/db/fixtures/Vibin_no_image.jpg"
  },
  {
    name:      "世界的な交響楽団",
    introduction: "ドイツの伝統的なオーケストラ。世界的に評価の高い演奏技術を誇り、数々の名曲を多彩に演奏する。指揮者とオーケストラの見事なハーモニーが観客を魅了する。",
    genre_name:   "クラシック",
    artist_image: "Vibin/db/fixtures/世界的な交響楽団.jpg"
  },
  {
    name:      "エテルナ・ソロイスト",
    introduction: "世界的に有名なクラシックのソリストたちのグループ。チェロ、ヴァイオリン、ピアノを中心に、情熱的な演奏が特徴。クラシック音楽の深さと美しさを表現している。",
    genre_name:   "クラシック",
    artist_image: "Vibin/db/fixtures/エテルナ・ソロイスト.jpg"
  },
  {
    name:      "藤井風雅",
    introduction: "日本の演歌歌手。故郷の風景を感じさせるような、優れた歌詞とメロディが特徴。数々の演歌大賞を受賞し、若年層からの支持も厚い。",
    genre_name:   "演歌",
    artist_image: "Vibin/db/fixtures/Vibin_no_image.jpg"
  },
  {
    name:      "山田たけし",
    introduction: "演歌界のベテラン歌手。長年にわたるキャリアを持ち、感情豊かな歌声で観客を魅了する。彼の歌声には、深い人生観が反映されている。",
    genre_name:   "演歌",
    artist_image: "Vibin/db/fixtures/Vibin_no_image.jpg"
  },
  {
    name:      "Rogue Sound",
    introduction: "ヒップホップの枠を超えた革新的なラップグループ。社会問題を歌詞に反映させ、リズムとリリックで強いメッセージを届けている。クールで力強いパフォーマンスが魅力。",
    genre_name:   "ラップ",
    artist_image: "Vibin/db/fixtures/Rogue Sound.jpg"
  },
  {
    name:      "エピック・フロー",
    introduction: "日本のラップグループ。スムーズなフローと深い歌詞が特徴で、ファンとのつながりを大切にした活動を行っている。アルバム『Beyond the Flow』は多くの支持を集めた。",
    genre_name:   "ラップ",
    artist_image: "Vibin/db/fixtures/エピック・フロー.jpg"
  }
]

artists.each do |attrs|
  genre = Genre.find_by!(name: attrs[:genre_name])
  artist = Artist.find_or_initialize_by(name: attrs[:name])
  artist.introduction = attrs[:introduction]
  artist.genre        = genre

  if attrs[:artist_image].present?
    # fixtures から画像を読み込んで ActiveStorage にアップロード
    artist.artist_image.attach(
      io: File.open(Rails.root.join("db", "fixtures", File.basename(attrs[:artist_image]))),
      filename: File.basename(attrs[:artist_image])
    )
  end

  artist.save!
end


Post.create( 
  post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/Fes1.jpg"), filename:"Fes1.jpg"),
  title: "アイドルのワールドツアー参戦！",
  body: "世界的なパフォーマンスを間近で体感。歓声と感動の渦に包まれた夜でした！",
  user: damiano
)
Post.create( 
  post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/Fes2.jpg"), filename:"Fes2.jpg"),
  title: "初めてのクラシックコンサート",
  body: "オーケストラの壮大な音に圧倒。心が浄化されるような不思議な体験ができた！",
  user: alicia
)
Post.create( 
  post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/Fes3.jpg"), filename:"Fes3.jpg"),
  title: "ロックバンドフェスで夏全開",
  body: "大好きなバンドの演奏に全力で叫び、汗だくになって、最高の思い出になった！",
  user: oliver
)
Post.create( 
  post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/Fes4.jpg"), filename:"Fes4.jpg"),
  title: "初めてのライブで感動",
  body: "生の演奏に圧倒！歌声もパフォーマンスも神がかってて鳥肌が止まらなかった！",
  user: victoria
)



puts "seedの実行が完了しました"