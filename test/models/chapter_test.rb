require "test_helper"

class ChapterTest < ActiveSupport::TestCase
  test "should not create chapter without title" do
    chapter = Chapter.new
    assert_not chapter.save, "Saved the chapter without a title"
  end

  test "should create chapter" do
    chapter = Chapter.new(title: "Sample")
    assert chapter.save, "Failed to save the chapter"
  end

  test "should have many verses" do
    chapter = Chapter.create(title: "Sample")
    verse1 = chapter.verses.create(verse_number: 1, text: "Sample")
    verse2 = chapter.verses.create(verse_number: 2, text: "Sample 2")

    assert_equal 2, chapter.verses_count
    assert_includes chapter.verses, verse1
    assert_includes chapter.verses, verse2
  end
end
