class Api::V1::VersesController < ApplicationController
    PER_PAGE = 20

    def index
        @verses = Verse.order(:verse_number).page(params[:page]).per(PER_PAGE)
        render json: {
                data: @verses,
                meta: {
                    pagination: {
                        current_page: @verses.current_page,
                        next_page: @verses.next_page,
                        prev_page: @verses.prev_page,
                        total_pages: @verses.total_pages,
                        total_count: @verses.total_count
                }
            }
        }
    end

    def show
        begin
            @verse = Verse.find(params[:id])
            render json: { data: @verse }
        rescue ActiveRecord::RecordNotFound
            render json: { error: "Verse not found" }, status: :not_found
        end
    end

    def random
        random_offset = rand(Verse.count)
        @verse = Verse.offset(random_offset).first
        render json: { data: @verse }
    end
end
