class CreateChapters < ActiveRecord::Migration[8.0]
  def change
    create_table :chapters do |t|
      t.integer :number
      t.string :title
      t.string :english_title
      t.string :pali_title

      t.timestamps
    end
  end
end
