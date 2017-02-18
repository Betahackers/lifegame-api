class CardsController < ApplicationController
  def index
    render json: {
      cards: [
        {
          id: 1,
          title: "Should we have a child?",
          person: "Fred",
          image_url: "http://pipsum.com/435x310.jpg",
          answers: [
            {
              id: 1,
              text: "Yes, go for it!",
              type: "left",
              points: [
                {
                  value: -10,
                  slug: "health"
                },
                {
                  value: 10,
                  slug: "family"
                }
              ]
            },
            {
              id: 2,
              text: "No! Never!",
              type: "right",
              points: [
                {
                  value: 10,
                  slug: "health"
                },
                {
                  value: -10,
                  slug: "family"
                }
              ]
            }
          ]
        },
        {
          id: 2,
          title: "Let's get naked!",
          person: "Fred",
          image_url: "http://pipsum.com/435x310.jpg",
          answers: [
            {
              id: 3,
              text: "Yes, go for it!",
              type: "left",
              points: [
                {
                  value: 10,
                  slug: "fun"
                },
                {
                  value: -10,
                  slug: "family"
                }
              ]
            },
            {
              id: 4,
              text: "No! Never!",
              type: "right",
              points: [
                {
                  value: 10,
                  slug: "money"
                },
                {
                  value: -10,
                  slug: "fun"
                }
              ]
            }
          ]
        }
      ]
    }
  end
end
