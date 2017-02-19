class CardsController < ApplicationController

  DEFAULT_START_AGE = 15
  DEFAULT_AGE_INCREMENT = 1

  def index
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

    render json: card_deck, include: "answers.points"
  end

  private

  def limit
    params[:limit] || default_limit
  end

  def default_limit
    70
  end
end
