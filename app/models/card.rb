class Card < ApplicationRecord
  DEFAULT_START_AGE = 15
  DEFAULT_AGE_INCREMENT = 1

  PERSON_ENUM = ['drug dealer', 'seller', 'smoky granny', 'friend', 'authority', 'kid', 'parents', 'ex', 'stranger', 'mum', 'trump', 'doctor', 'dad', 'guru', 'boss', 'sex friends', 'colleague', 'dog', 'lover', 'therapist']

  has_many :answers, dependent: :destroy

  validates_each :answers do |card, attr, value|
   card.errors.add attr, "too much answers for card" if card.answers.size > 2
  end


  validates_inclusion_of :person, in: PERSON_ENUM
  validates_presence_of :person
  validates_presence_of :title
  validates_presence_of :age_constraint
  validates_presence_of :answers

  validates_numericality_of :age_constraint



  def self.ordered(limit)
    cards = Card.all.includes(answers: :points).all

    card_deck = []

    safety_max_limit = 1000
    pick_count = 0

    current_age = DEFAULT_START_AGE

    while card_deck.size < [limit.to_i, cards.size].min && pick_count < safety_max_limit do
      pick_count += 1
      pick = cards.sample

      Rails.logger.debug "Current age #{current_age}"
      Rails.logger.debug "Picked card #{pick.id} with age_constraint: '#{pick.age_constraint}'"

      # ignore card if it does not fit age criteria
      if pick.constrained_by_age?(current_age)
        Rails.logger.debug "Whoops!  Constrained by age."
        next
      end

      Rails.logger.debug "Ok, not constrained by age"

      # ignore card if it is already included
      next if card_deck.include?(pick)

      Rails.logger.debug "Adding card #{pick.id} #{pick.title}"

      card_deck << pick

      # remove picked card from our selection
      cards = cards.select { |c| c!=pick }

      current_age += DEFAULT_AGE_INCREMENT
    end

    card_deck
  end

  def person_enum
    PERSON_ENUM
  end

  def constrained_by_age?(age)
    return false if age_constraint.blank?
    age_constraint < 0 ? age > age_constraint.abs : age < age_constraint
  end
end