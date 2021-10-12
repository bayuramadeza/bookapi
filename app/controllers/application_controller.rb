class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActionController::ParameterMissing, with: :missing_params

    private
    def not_destroyed(e)
        render json: {message: e.record.errors, data: nil}, status: :unprocessable_entity
    end

    def not_found(e)
        render json: {message: e, data: nil}, status: :not_found
    end

    def missing_params(e)
        render json: {message: e, data: nil}, status: :bad_request
    end
end
