class BooksController < ApplicationController
  def index
    render json: {message: "Berhasil get books", data: BooksRepresenter.new(Book.all).data_json}
  end

  def show 
      book = Book.find(params[:id])
      render json: {message: "Berhasil get books", data: book}
  end

  def create
    title = params[:title]
    file = params[:file]
    author_id = params[:author_id]
    book = Book.new(title: title, author_id: author_id)
    if book.save 
      file_response = Cloudinary::Uploader.upload(file, :public_id => book.id, :folder => '/files')
      if file_response
        render json: {
          message: "Berhasil menambahkan buku", 
          file_response: file_response,
          data: book
        },
        status: :created
      else 
        render json: {
          message: file_response.errors, 
          data: book
        },
        status: :unprocessable_entity
      end
    else
      render json: {
        message: book.errors.full_messages.to_sentence, 
        data: nil
      },
      status: :unprocessable_entity
    end
  end

  def update
    id = params[:id]
    book = Book.find(id)
    if book.update(book_params)
      render json: {
        message: "Berhasil update buku", 
        data: book
      }, status: :ok
    else
      render json: {
        message: "Gagal update buku",
        data: nil
      }, status: :unprocessable_entity
    end
  end

  def destroy
    id = params[:id]
    render json: {
      message: "Berhasil menghapus buku", 
      data: {
        id: id
      }
    }
  end

  private
  def book_params
    params.permit(:title, :author_id)
  end
end
