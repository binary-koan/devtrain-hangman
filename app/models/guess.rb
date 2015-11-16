class Guess < ActiveRecord::Base
  belongs_to :game

  validates :guessed_letter,
    format: { with: /\A[a-z]\z/, message: "must be one lowercase letter" },
    uniqueness: { scope: :game_id, message: "cannot be guessed more than once per game" }

  validate :game_isnt_finished

  def game_isnt_finished
    errors.add(:game, "must still be in progress") if game.won? || game.lost?
  end
end
