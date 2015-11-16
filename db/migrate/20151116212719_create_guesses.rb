class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.string :guessed_letter, null: false
      t.references :game, null: false, index: true

      t.timestamps null: false
    end
  end
end
