class Api::V1::SearchController < ApplicationController
  def index
    q = search_params[:q]

    if q.blank? || q.length < 3
      render json: {
        error: "Search query must be at least 3 characters long"
      }, status: 422
      return
    end

    @chapter_results = Chapter.where("title ILIKE ? OR english_title ILIKE ?", "%#{q}%", "%#{q}%")

    @verse_results = Verse.select(:id, :verse_number, :text, :english_text, :story_title, :english_story_title).where("text ILIKE ? OR english_text ILIKE ? OR story_title ILIKE ? OR english_story_title ILIKE ?", "%#{q}%", "%#{q}%", "%#{q}%", "%#{q}%")

    render json: {
      chapters: @chapter_results,
      verses: @verse_results
    }
  end

  private

  def search_params
    params.permit(:q)
  end
end
