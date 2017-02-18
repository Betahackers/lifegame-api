task fake_data: :environment do
  puts "Adding fake data"
  Card.destroy_all
  persons = ["Fred", "Mother", "Barbara", "Priest"]
  answer_kinds = ["left", "right"]
  point_types = ["money", "health", "love", "fun"]
  values = [-5, -3, 0, 3, 5]
  200.times do |c|
    card = Card.create(
      title: FFaker::HipsterIpsum.sentence[0..139],
      person: persons.sample,
      image_url: FFaker::Avatar.image
    )
    2.times do |a|
      answer = Answer.create(
        card: card,
        text: FFaker::HipsterIpsum.phrase[0..24],
        kind: answer_kinds[a]
      )
      (point_types.shuffle[0..(rand(3))]).each do |slug|
        Point.create(answer: answer, slug: slug, value: values.sample)
      end
    end

  end
end
