require 'csv'

# Card Title,Character,Left/Right,Answer Text,Love,Money,Fun,Health,Possible Death?,Age Constraint,Base Probability,Probability change per year
# "You have an STD, you have to stop having sex for a month, until we're completely sure you're healed.",doctor,Left,"No way, man.",0,0,10,-5,,-100,,
# "You have an STD, you have to stop having sex for a month, until we're completely sure you're healed.",doctor,Right,Alright man.,3,-3,3,0,,-100,,

task import_cards: :environment do
  puts "Importing cards"
  Card.destroy_all
  CSV.foreach("db/data/cards.csv") do |row|
    title = row[0].to_s.strip
    next if title.blank?
    person = row[1]
    kind = row[2].capitalize
    answer_text = row[3]
    love = row[4] || 0
    money = row[5] || 0
    fun = row[6] || 0
    health = row[7] || 0
    card = Card.where(title: title, person: person).first_or_create
    answer = Answer.create(
      card: card,
      text: answer_text,
      kind: kind
    )
    Point.create(answer: answer, slug: "love", value: love)
    Point.create(answer: answer, slug: "money", value: money)
    Point.create(answer: answer, slug: "fun", value: fun)
    Point.create(answer: answer, slug: "health", value: health)
  end
  puts "Cards: #{Card.count}"
  puts "Answers: #{Answer.count}"
  puts "Points: #{Point.count}"
end

