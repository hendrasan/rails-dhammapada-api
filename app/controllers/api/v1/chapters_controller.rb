class Api::V1::ChaptersController < ApplicationController
    def index
        @chapters = Chapter.order(:id)
        render json: { data: @chapters }
    end

    def show
        begin
            @chapter = Chapter.find(params[:id])
            @verses = @chapter.verses.select(:id, :verse_number, :text, :english_text, :story_title, :english_story_title).order(:verse_number)
            render json: { data: { chapter: @chapter, verses: @verses } }
        rescue ActiveRecord::RecordNotFound
            render json: { error: "Chapter not found" }, status: :not_found
        end
    end
end
