module Api
  class EntriesController < ApiController
    helper_method :end_date
    helper_method :start_date

    def index
      render json: filtered_entries
    end

    private

    def end_date
      @start_date ||= if filter_params[:end_date].present?
        Time.parse(filter_params[:end_date]).end_of_day
      else
        Time.current
      end
    rescue ArgumentError => error
      Raven.capture_exception(error)

      Time.current
    end

    def entries
      current_user.entries
    end

    def filter_params
      @filter_params ||= params.permit(
        :end_date,
      )
    end

    def filtered_entries
      entries
        .where(
          created_at:
        )
        .order(created_at: :asc)
    end

    def start_date
      @start_date ||= (end_date - 2.weeks).beginning_of_day
    end
  end
end
