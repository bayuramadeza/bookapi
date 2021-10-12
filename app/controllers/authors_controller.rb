class AuthorsController < ApplicationController
    def index
        render json: {message: "Berhasil get authors", data: Author.all}
    end

    def create
        last_name = params[:last_name]
        age = params[:age]

        author = Author.new(first_name: params[:first_name], last_name: last_name, age: age)
        if author.save
            render json: {
                message: 'Berhasil diciptakan',
                data: author
            }, status: :created
        else
            render json: {
                message: author.errors.full_messages.to_sentence,
                data: nil
            }, status: :unprocessable_entity
        end
    end
end
