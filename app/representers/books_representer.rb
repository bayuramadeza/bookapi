class BooksRepresenter
    def initialize(books)
        @books = books
    end

    def data_json
        @books.map do |book|
            {
                id: book.id,
                book_title: book.title,
                author_name: book.author.nil? ? nil : "#{book.author.first_name} #{book.author.last_name}"
            }
        end
    end

    private

    attr_reader :books
end