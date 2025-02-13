require "test_helper"

class VerseTest < ActiveSupport::TestCase
  test "should not create verse without all required fields" do
    verse = Verse.new
    assert_not verse.save, "Saved the verse without all required fields"
    assert verse.errors[:verse_number].any?, "Verse number is required"
    assert verse.errors[:chapter_id].any?, "Chapter ID is required"
    assert verse.errors[:text].any?, "Text is required"
  end

  test "should create verse with all required fields" do
    chapter = Chapter.create(title: "Sample")
    verse = Verse.new(verse_number: 1, chapter_id: chapter.id, text: "Sample")
    assert verse.save, "Failed to save the verse: #{verse.errors.full_messages.join(", ")}"
  end

  test "should belong to a chapter" do
    chapter = Chapter.create(title: "Sample")
    verse = chapter.verses.create(verse_number: 1, text: "Sample")

    assert_equal chapter.id, verse.chapter_id
  end
end
