class AddVersesCountToChapters < ActiveRecord::Migration[8.0]
  def change
    add_column :chapters, :verses_count, :integer
  end
end
