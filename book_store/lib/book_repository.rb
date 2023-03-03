require_relative 'book'

class BookRepository
  def list_all_books
    all_books = []
    sql = 'SELECT * FROM books'
    result = DatabaseConnection.exec_params(sql, [])

    result.each do |record| 
      book = Book.new
      book.id = record['id']
      book.title = record['title']
      book.author_name = record['author_name']
      all_books << book
    end

    all_books
  end
end