class Verse < ApplicationRecord
  validates :verse_number, presence: true
  validates :chapter_id, presence: true
  validates :text, presence: true

  belongs_to :chapter, counter_cache: true
end
