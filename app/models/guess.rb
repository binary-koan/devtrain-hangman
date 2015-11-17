class Guess < ActiveRecord::Base
  belongs_to :game

  validates :guessed_letter, format: {
    with: /\A[a-z]\z/, message: "must be one lowercase letter"
  }
end
