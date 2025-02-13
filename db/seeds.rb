# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'json'

Chapter.destroy_all
Verse.destroy_all

file = File.read('./script/db.json')
data_hash = JSON.parse(file)

indo_file = File.read('./script/db-indo.json')
indo_data_hash = JSON.parse(indo_file)

data_hash.each do |chapter_data|
    chapter = Chapter.create!(
        number: chapter_data['Chapter']['Nr'].to_i,
        title: chapter_data['Chapter']['Title'],
        english_title: chapter_data['Chapter']['Title'],
        pali_title: chapter_data['Chapter']['Pali'],
    )

    chapter_data["Chapter"]["Verses"]["Verse"].each do |verse_data|
        paragraphs_data = verse_data["Paragraphs"]["Par"]
        if paragraphs_data.is_a?(Array)
            paragraphs_data.each do |paragraph_data|
                chapter.verses.create!(
                    verse_number: paragraph_data["Nr"].to_i,
                    text: paragraph_data["Txt"],
                    english_text: paragraph_data["Txt"],
                    story_title: verse_data["Story"]["Title"],
                    english_story_title: verse_data["Story"]["Title"],
                    story: verse_data["Story"]["Txt"],
                    english_story: verse_data["Story"]["Txt"],
                )
            end
        else
            chapter.verses.create!(
                verse_number: verse_data["Paragraphs"]["Par"]["Nr"].to_i,
                text: verse_data["Paragraphs"]["Par"]["Txt"],
                english_text: verse_data["Paragraphs"]["Par"]["Txt"],
                story_title: verse_data["Story"]["Title"],
                english_story_title: verse_data["Story"]["Title"],
                story: verse_data["Story"]["Txt"],
                english_story: verse_data["Story"]["Txt"],
            )
        end
    end
end

Chapter.all.each do |chapter|
    indo_chapter = indo_data_hash.find { |indo_chapter| indo_chapter['number'] == chapter.number }
    if indo_chapter
        chapter.update!(
            title: indo_chapter['text'],
        )
    end
end

Verse.all.each do |verse|
    indo_chapter = indo_data_hash.find { |indo_chapter| indo_chapter['number'] == verse.chapter.number }
    if indo_chapter
        indo_verse = indo_chapter['verses'].find { |indo_verse| indo_verse['number'] == verse.verse_number }
        if indo_verse
            verse.update!(
                text: indo_verse['text'],
                story_title: indo_verse['story_title'],
                story: indo_verse['story'],
            )
        end
    end
end
