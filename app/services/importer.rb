class Importer
  attr_reader :doc

  def initialize(doc)
    @doc = doc
  end

  def call
    puts "Importing"
    import_cards
    import_endings
    show_counts
  end


  def import_cards
    Card.destroy_all
    card_sheets.each do |sheet|
      puts sheet.name
      sheet.rows.each do |row|
        import_card(row)
      end
    end
  end

  def import_endings
    Ending.destroy_all
    puts "Endings"
    endings_sheets.each do |sheet|
      sheet.rows.each do |row|
        import_ending(row)
      end
    end
  end

  private

  def sheets
    @doc.sheets
  end

  def sheet_by_name(name)
    sheets.find { |sheet| sheet.name == name }
  end

  def card_sheets
    sheets.select { |sheet| card_sheet_names.include?(sheet.name) }
  end

  def endings_sheets
    sheets.select { |sheet| ending_sheet_names.include?(sheet.name) }
  end

  def card_sheet_names
    ["Health", "Fun", "$", "Love"]
  end

  def ending_sheet_names
    ["Endings"]
  end

  # Card Title,Character,Left/Right,Answer Text,Love,Money,Fun,Health,Possible Death?,Age Constraint,Base Probability,Probability change per year
  # "You have an STD, you have to stop having sex for a month, until we're completely sure you're healed.",doctor,Left,"No way, man.",0,0,10,-5,,-100,,
  # "You have an STD, you have to stop having sex for a month, until we're completely sure you're healed.",doctor,Right,Alright man.,3,-3,3,0,,-100,,

  def import_card(row)
    title = row[0].to_s.strip
    return if title.blank? || title == "Card Title"
    person = row[1]
    kind = row[2].capitalize
    answer_text = row[3]
    love = row[4] || 0
    money = row[5] || 0
    fun = row[6] || 0
    health = row[7] || 0
    age_constraint = row[9]
    card = Card.where(title: title, person: person, age_constraint: age_constraint).first_or_create
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

  def import_ending(row)
    return if row[1].to_s.strip == "Min/Max" || row[0].to_s.blank?
    Ending.create(reason: [row[0], row[1]].join("_").downcase, cause: row[2], effect: row[3])
  end

  def show_counts
    puts "Cards: #{Card.count}"
    puts "Answers: #{Answer.count}"
    puts "Points: #{Point.count}"
    puts "Endings: #{Ending.count}"
  end

end