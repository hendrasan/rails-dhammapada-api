class CreateVerses < ActiveRecord::Migration[8.0]
  def change
    create_table :verses do |t|
      t.references :chapter, null: false, foreign_key: true
      t.integer :verse_number
      t.text :text
      t.text :english_text
      t.text :pali_text
      t.text :story_title
      t.text :english_story_title
      t.text :story
      t.text :english_story

      t.timestamps
    end
  end
end
